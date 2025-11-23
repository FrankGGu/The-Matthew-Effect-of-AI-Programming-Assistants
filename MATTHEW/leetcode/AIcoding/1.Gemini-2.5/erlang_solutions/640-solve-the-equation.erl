-module(solution).
-export([solve_equation/1]).

solve_equation(Equation) ->
    [LeftStr, RightStr] = string:split(Equation, "=", all),
    {LX, LC} = parse_side(LeftStr),
    {RX, RC} = parse_side(RightStr),

    TotalX = LX - RX,
    TotalConst = RC - LC,

    if
        TotalX == 0 andalso TotalConst == 0 ->
            "Infinite solutions";
        TotalX == 0 andalso TotalConst /= 0 ->
            "No solution";
        true -> % TotalX /= 0
            XVal = TotalConst div TotalX,
            io_lib:format("x=~p", [XVal])
    end.

parse_side(Str) ->
    parse_side_acc(string:to_list(Str), 0, 0, 1).

parse_side_acc([], AccX, AccC, _CurrentTermSign) ->
    {AccX, AccC};
parse_side_acc([$+|T], AccX, AccC, _CurrentTermSign) ->
    parse_side_acc(T, AccX, AccC, 1);
parse_side_acc([$-|T], AccX, AccC, _CurrentTermSign) ->
    parse_side_acc(T, AccX, AccC, -1);
parse_side_acc(StrList, AccX, AccC, CurrentTermSign) ->
    {TermStrList, RestList} = extract_term_string(StrList),
    {TermX, TermC} = parse_single_term(TermStrList, CurrentTermSign),
    parse_side_acc(RestList, AccX + TermX, AccC + TermC, 1).

extract_term_string(StrList) ->
    extract_term_string(StrList, []).

extract_term_string([], Acc) ->
    {lists:reverse(Acc), []};
extract_term_string([H|T], Acc) when H == $+; H == $- ->
    {lists:reverse(Acc), [H|T]};
extract_term_string([H|T], Acc) ->
    extract_term_string(T, [H|Acc]).

parse_single_term(TermStrList, Sign) ->
    case lists:member($x, TermStrList) of
        false -> % It's a constant
            ConstVal = list_to_integer(TermStrList),
            {0, ConstVal * Sign};
        true -> % It's an x term
            DigitsList = lists:filter(fun(C) -> C /= $x end, TermStrList),
            Coeff = case DigitsList of
                        [] -> 1; % "x" implies coefficient 1
                        _ -> list_to_integer(DigitsList)
                    end,
            {Coeff * Sign, 0}
    end.