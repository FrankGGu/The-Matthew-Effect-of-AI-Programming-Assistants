-module(solution).
-export([ways_to_split/1]).

ways_to_split(Array) ->
    N = length(Array),
    PrefixSum = lists:foldl(fun(X, {Acc, Sum}) -> {Acc ++ [Sum + X], Sum + X} end, {[], 0}, Array),
    TotalSum = lists:last(PrefixSum),
    {Prefix, _} = lists:split(N - 1, lists:element(1, PrefixSum)),
    lists:foldl(fun(X, Acc) -> 
        case X of
            {P1, P2, P3} when P1 < P2, P2 < P3 -> Acc + 1;
            _ -> Acc
        end 
    end, 0, 
    lists:zip(Prefix, [X || {X, Y} <- lists:zip(Prefix, tl(Prefix)), X < TotalSum div 3, Y > TotalSum div 3]).