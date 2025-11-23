-module(spreadsheet).
-export([new/0, get/2, set/3]).

-record(state, {cells = #{} :: map()}).

new() ->
    #state{}.

set(State, CellName, Value) ->
    CellRef = string_to_cell_ref(CellName),
    NewCells = maps:put(CellRef, Value, State#state.cells),
    State#state{cells = NewCells}.

get(State, CellName) ->
    CellRef = string_to_cell_ref(CellName),
    eval_cell(State, CellRef, []).

eval_cell(State, CellRef, Path) ->
    if lists:member(CellRef, Path) ->
        0; % Circular dependency detected
    true ->
        NewPath = [CellRef | Path],
        try
            case maps:get(CellRef, State#state.cells, undefined) of
                undefined -> 0; % Cell not set, default to 0
                Value when is_integer(Value) -> Value;
                FormulaString when is_list(FormulaString) ->
                    % Remove leading '='
                    ExpressionString = tl(FormulaString),
                    Tokens = tokenize(ExpressionString),
                    eval_expression(Tokens, State, NewPath)
            end
        catch
            error:_ -> 0; % Any parsing or evaluation error returns 0
            throw:_ -> 0;
            exit:_ -> 0
        end
    end.

string_to_cell_ref(CellNameString) ->
    {ColStr, RowStr} = split_cell_name_string(CellNameString),
    Col = parse_col_str(ColStr),
    Row = list_to_integer(RowStr) - 1, % 1-indexed to 0-indexed
    {Row, Col}.

split_cell_name_string(CellNameString) ->
    split_cell_name_string(CellNameString, [], []).

split_cell_name_string([], ColAcc, RowAcc) -> {lists:reverse(ColAcc), lists:reverse(RowAcc)};
split_cell_name_string([H|T], ColAcc, RowAcc) when H >= $A, H =< $Z ->
    split_cell_name_string(T, [H|ColAcc], RowAcc);
split_cell_name_string([H|T], ColAcc, RowAcc) when H >= $0, H =< $9 ->
    split_cell_name_string(T, ColAcc, [H|RowAcc]);
split_cell_name_string(_, _, _) -> error(bad_cell_name_format).

parse_col_str(ColStr) -> parse_col_str_acc(ColStr, 0) - 1.

parse_col_str_acc([], Acc) -> Acc;
parse_col_str_acc([H|T], Acc) -> parse_col_str_acc(T, Acc * 26 + (H - $A + 1)).

tokenize(String) -> tokenize(String, []).

tokenize([], Acc) -> lists:reverse([{eof} | Acc]);
tokenize([H|T], Acc) when H =:= $\s -> tokenize(T, Acc); % Skip whitespace
tokenize([H|T], Acc) when H =:= $( -> tokenize(T, [{lparen}|Acc]);
tokenize([H|T], Acc) when H =:= $) -> tokenize(T, [{rparen}|Acc]);
tokenize([H|T], Acc) when H =:= $+; H =:= $-; H =:= $*; H =:= $/ -> tokenize(T, [{op, H}|Acc]);
tokenize([H|T], Acc) when H >= $0, H =< $9 ->
    {NumStrRev, Rest} = take_digits([H|T], []),
    tokenize(Rest, [{int, list_to_integer(lists:reverse(NumStrRev))}|Acc]);
tokenize([H|T], Acc) when H >= $A, H =< $Z ->
    {ColStrRev, Rem1} = take_letters([H|T], []),
    {RowStrRev, Rem2} = take_digits(Rem1, []),
    CellRef = string_to_cell_ref_from_parts(lists:reverse(ColStrRev), lists:reverse(RowStrRev)),
    tokenize(Rem2, [{cell_ref, CellRef}|Acc]).

take_digits([H|T], Acc) when H >= $0, H =< $9 -> take_digits(T, [H|Acc]);
take_digits(List, Acc) -> {Acc, List}. % Acc is built in reverse order

take_letters([H|T], Acc) when H >= $A, H =< $Z -> take_letters(T, [H|Acc]);
take_letters(List, Acc) -> {Acc, List}. % Acc is built in reverse order

string_to_cell_ref_from_parts(ColStr, RowStr) ->
    Col = parse_col_str(ColStr),
    Row = list_to_integer(RowStr) - 1,
    {Row, Col}.

eval_expression(Tokens, State, Path) ->
    {Value, RemainingTokens} = parse_expr(Tokens, State, Path),
    case RemainingTokens of
        [{eof}] -> Value;
        _ -> error(bad_expression_syntax) % Trailing tokens
    end.

parse_expr(Tokens, State, Path) ->
    {LHS, Rest1} = parse_term(Tokens, State, Path),
    parse_expr_rest(LHS, Rest1, State, Path).

parse_expr_rest(Acc, [{op, Op}|T], State, Path) when Op =:= $+; Op =:= $- ->
    {RHS, Rest} = parse_term(T, State, Path),
    NewAcc = case Op of
                 $+ -> Acc + RHS;
                 $- -> Acc - RHS
             end,
    parse_expr_rest(NewAcc, Rest, State, Path);
parse_expr_rest(Acc, Tokens, _, _) -> {Acc, Tokens}.

parse_term(Tokens, State, Path) ->
    {LHS, Rest1} = parse_factor(Tokens, State, Path),
    parse_term_rest(LHS, Rest1, State, Path).

parse_term_rest(Acc, [{op, Op}|T], State, Path) when Op =:= $*; Op =:= $/ ->
    {RHS, Rest} = parse_factor(T, State, Path),
    NewAcc = case Op of
                 $* -> Acc * RHS;
                 $/ -> if RHS =:= 0 -> 0; true -> Acc div RHS end % Integer division, divide by zero -> 0
             end,
    parse_term_rest(NewAcc, Rest, State, Path);
parse_term_rest(Acc, Tokens, _, _) -> {Acc, Tokens}.

parse_factor([{int, N}|T], _, _) -> {N, T};
parse_factor([{cell_ref, CellRef}|T], State, Path) ->
    Value = eval_cell(State, CellRef, Path),
    {Value, T};
parse_factor([{lparen}|T], State, Path) ->
    {Value, Rest} = parse_expr(T, State, Path),
    case Rest of
        [{rparen}|Rest2] -> {Value, Rest2};
        _ -> error(missing_rparen)
    end;
parse_factor(Tokens, _, _) -> error({unexpected_token, hd(Tokens)}).