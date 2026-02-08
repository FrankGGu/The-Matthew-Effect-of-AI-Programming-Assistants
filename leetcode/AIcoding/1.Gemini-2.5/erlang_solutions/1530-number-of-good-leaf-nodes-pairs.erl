-module(solution).
-export([countGoodLeafNodesPairs/2]).

countGoodLeafNodesPairs(Root, Distance) ->
    {Count, _} = dfs(Root, Distance),
    Count.

dfs(nil, _MaxDistance) ->
    {0, #{}};
dfs({tree_node, _, nil, nil}, _MaxDistance) -> %% Leaf node
    {0, #{1 => 1}}; % Distance from parent to this leaf is 1. One leaf at this distance.
dfs({tree_node, _, Left, Right}, MaxDistance) ->
    {LeftCount, LeftFreqMap} = dfs(Left, MaxDistance),
    {RightCount, RightFreqMap} = dfs(Right, MaxDistance),

    CurrentPairs = count_pairs(LeftFreqMap, RightFreqMap, MaxDistance),

    NewFreqMap = merge_freq_maps(LeftFreqMap, RightFreqMap, MaxDistance),

    {LeftCount + RightCount + CurrentPairs, NewFreqMap}.

count_pairs(Freq1, Freq2, MaxDistance) ->
    lists:foldl(fun({D1, C1}, Acc) ->
        maps:fold(fun(D2, C2, InnerAcc) ->
            if D1 + D2 =< MaxDistance -> InnerAcc + C1 * C2;
               true -> InnerAcc
            end
        end, Acc, Freq2)
    end, 0, maps:to_list(Freq1)).

merge_freq_maps(Freq1, Freq2, MaxDistance) ->
    NewMap = maps:new(),

    % Add transformed left distances
    NewMap1 = maps:fold(fun(D, C, Acc) ->
        if D + 1 =< MaxDistance -> maps:update_with(D + 1, fun(Val) -> Val + C end, C, Acc);
           true -> Acc
        end
    end, NewMap, Freq1),

    % Add transformed right distances
    maps:fold(fun(D, C, Acc) ->
        if D + 1 =< MaxDistance -> maps:update_with(D + 1, fun(Val) -> Val + C end, C, Acc);
           true -> Acc
        end
    end, NewMap1, Freq2).