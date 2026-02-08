-module(solution).
-export([num_subsets/1]).

num_subsets(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Nums),
    Max = lists:max(Nums),
    DP = array:new([{size, Max + 1}, {default, 0}]),
    DP1 = array:set(1, 1, DP),
    lists:foreach(fun(I) -> 
        case maps:get(I, Count, 0) of
            0 -> ok;
            C -> 
                lists:foreach(fun(J) -> 
                    if J rem I == 0 -> ok;
                       true -> 
                           Val = array:get(J, DP1),
                           array:set(J, Val + C * array:get(J div I, DP1), DP1)
                    end
                end, lists:seq(1, Max))
        end
    end, lists:seq(1, Max)),
    array:get(Max, DP1).

lists:seq(Start, End) when Start > End -> [];
lists:seq(Start, End) -> [Start | lists:seq(Start + 1, End)].