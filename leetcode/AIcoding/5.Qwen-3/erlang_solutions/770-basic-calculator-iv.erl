-module(basic_calculator_iv).
-export([calculate/1]).

calculate(Str) ->
    Tokens = tokenize(Str),
    {Result, _} = parse(Tokens, 0, []),
    Result.

tokenize(Str) ->
    tokenize(Str, []).

tokenize([], Acc) ->
    lists:reverse(Acc);
tokenize([$\s | T], Acc) ->
    tokenize(T, Acc);
tokenize([C | T], Acc) when C >= $0, C =< $9 ->
    {Num, Rest} = collect_digits([C | T]),
    tokenize(Rest, [list_to_integer(Num) | Acc]);
tokenize([C | T], Acc) when C == $+; C == $-; C == $*; C == $/; C == $(); C == $) ->
    tokenize(T, [C | Acc]);
tokenize([C | T], Acc) ->
    tokenize(T, [C | Acc]).

collect_digits([C | T]) when C >= $0, C =< $9 ->
    collect_digits([C | T], []).

collect_digits([], Acc) ->
    {lists:flatten(Acc), []};
collect_digits([C | T], Acc) when C >= $0, C =< $9 ->
    collect_digits(T, [C | Acc]);
collect_digits([C | T], Acc) ->
    {lists:flatten(Acc), [C | T]}.

parse([], _, _) ->
    {0, []};
parse([Token | Rest], Precedence, Stack) ->
    case Token of
        '+' -> 
            {Left, NewStack} = pop_stack(Stack, 1),
            {Right, NewRest} = parse(Rest, 0, []),
            {Left + Right, NewRest};
        '-' -> 
            {Left, NewStack} = pop_stack(Stack, 1),
            {Right, NewRest} = parse(Rest, 0, []),
            {Left - Right, NewRest};
        '*' -> 
            {Left, NewStack} = pop_stack(Stack, 2),
            {Right, NewRest} = parse(Rest, 0, []),
            {Left * Right, NewRest};
        '/' -> 
            {Left, NewStack} = pop_stack(Stack, 2),
            {Right, NewRest} = parse(Rest, 0, []),
            {Left div Right, NewRest};
        '(' -> 
            {Value, NewRest} = parse(Rest, 0, []),
            {Value, NewRest};
        ')' -> 
            {Value, NewRest} = pop_stack(Stack, 0),
            {Value, NewRest};
        _ when is_integer(Token) -> 
            {Token, Rest}
    end.

pop_stack([], _) ->
    {0, []};
pop_stack([H | T], TargetPrecedence) ->
    if
        H == '+' orelse H == '-' -> 
            {H, T};
        H == '*' orelse H == '/' -> 
            {H, T};
        true -> 
            {H, T}
    end.