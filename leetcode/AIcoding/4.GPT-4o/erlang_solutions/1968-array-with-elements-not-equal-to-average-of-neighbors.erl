-module(solution).
-export([solve/1]).

solve(List) ->
    lists:filter(fun({Value, Index}) -> 
        is_not_average(Value, Index, List) 
    end, lists:with_index(List)).

is_not_average(Value, Index, List) ->
    Prev = case Index of
        0 -> undefined;
        _ -> lists:nth(Index, List)
    end,
    Next = case Index of
        N when N == length(List) - 1 -> undefined;
        _ -> lists:nth(Index + 2, List)
    end,
    case {Prev, Next} of
        {undefined, _} -> true;
        {_, undefined} -> true;
        {P, N} -> Value =/= (P + N) / 2
    end.