-module(solution).
-export([min_cost/3]).

min_cost(S, T, Cost) ->
    N = length(S),
    M = length(T),
    if
        N /= M -> -1;
        true ->
            CostMap = array:from_list(Cost),
            DP = array:new(N, {default, 0}),
            DP1 = array:set(0, 0, DP),
            min_cost(S, T, CostMap, 0, N-1, DP1)
    end.

min_cost(_, _, _, I, N, DP) when I >= N ->
    array:get(N, DP);
min_cost(S, T, CostMap, I, N, DP) ->
    CharS = lists:nth(I+1, S),
    CharT = lists:nth(I+1, T),
    if
        CharS == CharT ->
            DP1 = array:set(I+1, array:get(I, DP), DP),
            min_cost(S, T, CostMap, I+1, N, DP1);
        true ->
            MinCost = find_min_cost(S, T, CostMap, I, N, DP),
            DP1 = array:set(I+1, MinCost, DP),
            min_cost(S, T, CostMap, I+1, N, DP1)
    end.

find_min_cost(S, T, CostMap, I, N, DP) ->
    CharS = lists:nth(I+1, S),
    CharT = lists:nth(I+1, T),
    Options = [],
    find_min_cost(S, T, CostMap, I, N, DP, CharS, CharT, Options).

find_min_cost(_, _, _, _, N, DP, _, _, Options) when N < 0 ->
    lists:min(Options);
find_min_cost(S, T, CostMap, I, N, DP, CharS, CharT, Options) ->
    CurrentChar = lists:nth(N+1, S),
    TargetChar = lists:nth(N+1, T),
    Cost = array:get((CurrentChar - $a) * 26 + (TargetChar - $a), CostMap),
    NewOptions = [array:get(N, DP) + Cost | Options],
    find_min_cost(S, T, CostMap, I, N-1, DP, CharS, CharT, NewOptions).