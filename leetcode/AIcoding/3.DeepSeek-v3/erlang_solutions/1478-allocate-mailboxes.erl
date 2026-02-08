-module(solution).
-export([min_distance/2]).

min_distance(Houses, K) ->
    SortedHouses = lists:sort(Houses),
    N = length(SortedHouses),
    Costs = array:new([{size, N}, {default, array:new([{size, N}, {default, 0}])}]),
    Costs1 = fill_costs(SortedHouses, Costs, 0, N - 1),
    DP = array:new([{size, N}, {default, array:new([{size, K + 1}, {default, -1}])}]),
    {Result, _} = dp(SortedHouses, Costs1, DP, 0, K),
    Result.

fill_costs(Houses, Costs, I, J) when I >= J ->
    Costs;
fill_costs(Houses, Costs, I, J) ->
    Mid = (I + J) div 2,
    Median = lists:nth(Mid + 1, Houses),
    Sum = lists:sum([abs(H - Median) || H <- lists:sublist(Houses, I + 1, J - I + 1)]),
    Costs1 = array:set(I, array:set(J, Sum, array:get(I, Costs)), Costs),
    fill_costs(Houses, Costs1, I + 1, J).

dp(Houses, Costs, DP, I, K) when K =:= 0 ->
    if
        I =:= length(Houses) -> {0, DP};
        true -> {999999999, DP}
    end;
dp(Houses, Costs, DP, I, K) when I >= length(Houses) ->
    if
        K =:= 0 -> {0, DP};
        true -> {999999999, DP}
    end;
dp(Houses, Costs, DP, I, K) ->
    case array:get(I, array:get(K, DP)) of
        -1 ->
            N = length(Houses),
            Min = lists:min([begin
                                {Cost1, DP1} = dp(Houses, Costs, DP, J + 1, K - 1),
                                Cost = array:get(I, array:get(J, Costs)) + Cost1,
                                {Cost, DP1}
                            end || J <- lists:seq(I, N - 1)]),
            {Val, DP2} = Min,
            DP3 = array:set(I, array:set(K, Val, array:get(I, DP2)), DP2),
            {Val, DP3};
        Val ->
            {Val, DP}
    end.