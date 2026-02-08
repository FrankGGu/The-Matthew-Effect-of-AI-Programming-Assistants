-module(solution).
-export([solve/1]).

solve(Equation) ->
    {LHS, RHS} = split_eq(Equation),
    {A, B} = parse(LHS),
    {C, D} = parse(RHS),
    Coeff = A - C,
    Const = D - B,
    case Coeff of
        0 -> 
            if 
                Const == 0 -> "Infinite solutions";
                true -> "No solution"
            end;
        _ -> 
            X = div(Const, Coeff),
            "x=" ++ integer_to_list(X)
    end.

split_eq(Equation) ->
    {lists:sublist(Equation, lists:findfirst(fun(C) -> C == '=' end, Equation)),
     lists:sublist(Equation, lists:nth(1, lists:findall(fun(C) -> C == '=' end, Equation)) + 1)}.

parse(S) ->
    {A, B} = parse_coeff(S, 0, 0),
    {A, B}.

parse_coeff(S, A, B) ->
    case S of
        [] -> {A, B};
        [$+ | Rest] -> parse_coeff(Rest, A, B);
        [$- | Rest] -> parse_coeff(Rest, A, B - 1);
        [C | Rest] when C >= $0, C =< $9 -> 
            {Num, NewRest} = parse_number([C | Rest]),
            parse_coeff(NewRest, A, B + Num);
        _ -> 
            parse_coeff(tl(S), A, B)
    end.

parse_number(S) ->
    parse_number(S, 0).

parse_number([], Acc) -> {Acc, []};
parse_number([C | Rest], Acc) when C >= $0, C =< $9 ->
    parse_number(Rest, Acc * 10 + (C - $0));
parse_number(Rest, Acc) -> {Acc, Rest}.