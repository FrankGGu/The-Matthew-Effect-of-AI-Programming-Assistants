-module(solution).
-export([findLonely/1]).

findLonely(Nums) ->
    {FreqMap, NumSet} = lists:foldl(
        fun(N, {AccFreqMap, AccNumSet}) ->
            NewFreqMap = maps:update_with(N, fun(Count) -> Count + 1 end, 1, AccFreqMap),
            NewNumSet = sets:add_element(N, AccNumSet),
            {NewFreqMap, NewNumSet}
        end,
        {#{}, sets:new()},
        Nums
    ),
    lists:filter(
        fun(N) ->
            maps:get(N, FreqMap) == 1 andalso
            not sets:is_element(N - 1, NumSet) andalso
            not sets:is_element(N + 1, NumSet)
        end,
        Nums
    ).