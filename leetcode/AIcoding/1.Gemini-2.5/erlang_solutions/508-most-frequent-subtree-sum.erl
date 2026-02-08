-module(solution).
-export([findFrequentTreeSum/1]).

-record('TreeNode', {val, left, right}).

findFrequentTreeSum(Root) ->
    case Root of
        nil -> [];
        _ ->
            {_TotalSum, AllSums} = dfs(Root, []),
            FreqMap = lists:foldl(fun(Sum, AccMap) ->
                                          maps:update_with(Sum, fun(Count) -> Count + 1 end, 1, AccMap)
                                  end, maps:new(), AllSums),
            find_max_freq_sums(FreqMap)
    end.

dfs(nil, AccSums) ->
    {0, AccSums};
dfs(#'TreeNode'{val = Val, left = Left, right = Right}, AccSums) ->
    {LeftSum, AccSums1} = dfs(Left, AccSums),
    {RightSum, AccSums2} = dfs(Right, AccSums1),
    CurrentNodeSum = Val + LeftSum + RightSum,
    {CurrentNodeSum, [CurrentNodeSum | AccSums2]}.

find_max_freq_sums(FreqMap) ->
    case maps:to_list(FreqMap) of
        [] -> [];
        [{_Sum1, Freq1} | _] = List ->
            MaxFreq = lists:foldl(fun({_Sum, Freq}, CurrentMax) -> max(Freq, CurrentMax) end, Freq1, List),
            [Sum || {Sum, Freq} <- List, Freq == MaxFreq]
    end.