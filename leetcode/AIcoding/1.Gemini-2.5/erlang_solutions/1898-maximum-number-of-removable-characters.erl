-module(solution).
-export([maximumRemovable/3]).

maximumRemovable(S, P, Removable) ->
    LenRemovable = length(Removable),

    % Helper function to check if P is a subsequence of S after removing the first K characters
    check = fun(K) ->
        % Create a set of 0-based indices to be removed
        % K can be 0, so lists:sublist(Removable, 0) is []
        RemovedIndicesSet = lists:foldl(fun(Index, Acc) -> sets:add_element(Index, Acc) end, sets:new(), lists:sublist(Removable, K)),

        % Optimized two-pointer iteration using list traversal
        is_subsequence_optimized(S, P, RemovedIndicesSet, 0)
    end,

    % Binary search for the maximum K
    Low = 0,
    High = LenRemovable,
    Ans = 0,

    binary_search(Low, High, Ans, check).

is_subsequence_optimized([], [], _RemovedIndicesSet, _CurrentS_idx) -> true;
is_subsequence_optimized(_S_list, [], _RemovedIndicesSet, _CurrentS_idx) -> true; % P is fully matched
is_subsequence_optimized([], _P_list, _RemovedIndicesSet, _CurrentS_idx) -> false; % S exhausted, P not fully matched
is_subsequence_optimized([H_S | T_S], [H_P | T_P], RemovedIndicesSet, CurrentS_idx) ->
    if
        sets:is_element(CurrentS_idx, RemovedIndicesSet) ->
            % Current character in S is marked as removed, skip it
            is_subsequence_optimized(T_S, [H_P | T_P], RemovedIndicesSet, CurrentS_idx + 1);
        H_S == H_P ->
            % Match found, advance both pointers (consume characters from both lists)
            is_subsequence_optimized(T_S, T_P, RemovedIndicesSet, CurrentS_idx + 1);
        true ->
            % No match, advance S pointer only (consume character from S, keep P's head)
            is_subsequence_optimized(T_S, [H_P | T_P], RemovedIndicesSet, CurrentS_idx + 1)
    end.

binary_search(Low, High, Ans, CheckFun) ->
    if
        Low > High ->
            Ans;
        true ->
            Mid = Low + (High - Low) div 2,
            if
                CheckFun(Mid) ->
                    % If P is a subsequence with Mid removals, try to remove more
                    binary_search(Mid + 1, High, Mid, CheckFun);
                true ->
                    % If P is not a subsequence with Mid removals, try to remove fewer
                    binary_search(Low, Mid - 1, Ans, CheckFun)
            end
    end.