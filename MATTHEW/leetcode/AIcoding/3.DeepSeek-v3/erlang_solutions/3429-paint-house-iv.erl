-module(solution).
-export([min_cost/2]).

min_cost(Houses, Cost) ->
    {M, N} = {length(Houses), length(hd(Cost))},
    DP = array:new([{size, M}, {default, array:new([{size, N}, {default, -1}])}]),
    case solve(0, 0, Houses, Cost, DP, M, N) of
        infinity -> -1;
        Res -> Res
    end.

solve(I, PrevColor, Houses, Cost, DP, M, N) when I =:= M ->
    0;
solve(I, PrevColor, Houses, Cost, DP, M, N) ->
    case array:get(I, array:get(PrevColor, DP)) of
        -1 ->
            CurrentHouse = lists:nth(I + 1, Houses),
            MinCost = if
                CurrentHouse =:= 0 ->
                    lists:min(lists:map(
                        fun(Color) ->
                            if
                                Color =/= PrevColor orelse I =:= 0 ->
                                    CostVal = lists:nth(I + 1, Cost),
                                    ColorCost = lists:nth(Color, CostVal),
                                    ColorCost + solve(I + 1, Color, Houses, Cost, DP, M, N);
                                true ->
                                    infinity
                            end
                        end,
                        lists:seq(1, N)));
                true ->
                    if
                        lists:nth(I + 1, Houses) =/= PrevColor orelse I =:= 0 ->
                            solve(I + 1, lists:nth(I + 1, Houses), Houses, Cost, DP, M, N);
                        true ->
                            infinity
                    end
            end,
            NewDP = array:set(I, array:set(PrevColor, MinCost, array:get(I, DP)), DP),
            MinCost;
        Cached ->
            Cached
    end.