-module(solution).
-export([beautifulSubsets/2]).

beautifulSubsets(Nums, K) ->
    SortedNums = lists:sort(Nums),
    backtrack(SortedNums, K, 0, #{}).

backtrack(Nums, K, Index, CurrentFreqMap) ->
    Len = length(Nums),
    if Index == Len ->
        if maps:size(CurrentFreqMap) > 0 -> 1;
        true -> 0
        end;
    true ->
        Num = lists:nth(Index + 1, Nums),

        CountWithoutNum = backtrack(Nums, K, Index + 1, CurrentFreqMap),

        HasForbiddenLower = maps:is_key(Num - K, CurrentFreqMap) andalso maps:get(Num - K, CurrentFreqMap) > 0,
        HasForbiddenUpper = maps:is_key(Num + K, CurrentFreqMap) andalso maps:get(Num + K, CurrentFreqMap) > 0,

        CountWithNum =
            if not HasForbiddenLower andalso not HasForbiddenUpper ->
                NewFreqMap = maps:update_with(Num, fun(V) -> V + 1 end, 1, CurrentFreqMap),
                backtrack(Nums, K, Index + 1, NewFreqMap);
            true ->
                0
            end,
        CountWithoutNum + CountWithNum
    end.