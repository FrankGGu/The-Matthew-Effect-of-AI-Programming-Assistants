-module(minimum_cost_to_make_all_characters_equal).
-export([minCost/1]).

minCost(Chars) ->
    Length = erlang:length(Chars),
    Half = Length div 2,
    Count = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Chars),
    Keys = maps:keys(Count),
    lists:foldl(fun(K, Acc) -> 
        Cnt = maps:get(K, Count),
        Cost = abs(Half - Cnt),
        Acc + Cost * (lists:sum([maps:get(K, Count) || K <- Keys]) - Cnt)
    end, 0, Keys).