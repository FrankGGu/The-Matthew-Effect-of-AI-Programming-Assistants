-module(solution).
-export([longestUnequalAdjacentGroupsSubsequence/2]).

longestUnequalAdjacentGroupsSubsequence(Groups, _Words) ->
    N = length(Groups),

    % Preprocess groups into an array: ProcessedGroups_Array[i] = {GroupSize, FirstChar}
    % Using an array for O(1) access to group properties.
    ProcessedGroups_Array = preprocess_groups_to_array(Groups, N),

    % DP state: dp[i] = {Length, PrevIndex}
    % Length: length of the longest subsequence ending at index i
    % PrevIndex: index of the previous group in that subsequence
    % Use a map for DP. Map access/update is O(log N).
    % Initialize dp with {1, -1} for all groups.
    DP_Initial = maps:from_list([{I, {1, -1}} || I <- lists:seq(0, N-1)]),

    % Iterate through groups to fill DP table
    DP_Final = fill_dp(ProcessedGroups_Array, N, DP_Initial),

    % Find the maximum length and its ending index
    {MaxLen, LastIdx} = find_max_len_and_idx(DP_Final, N),

    % Reconstruct the path if a subsequence was found
    if MaxLen > 0 ->
        reconstruct_path(DP_Final, LastIdx, [])
    else
        [] % Should not happen based on constraints (N >= 1)
    end.

preprocess_groups_to_array(Groups, N) ->
    Items = lists:map(fun(Group) -> {length(Group), hd(Group)} end, Groups),
    array:from_list(Items). % Creates a 0-indexed array

fill_dp(ProcessedGroups_Array, N, DP_Current_Map) ->
    fill_dp_loop(ProcessedGroups_Array, N, 0, DP_Current_Map).

fill_dp_loop(_ProcessedGroups_Array, N, N, DP_Final_Map) -> DP_Final_Map;
fill_dp_loop(ProcessedGroups_Array, N, I, DP_Current_Map) ->
    {SizeI, CharI} = array:get(I, ProcessedGroups_Array), % O(1)

    NewDP_Current_Map = fill_dp_inner_loop(ProcessedGroups_Array, I, SizeI, CharI, 0, DP_Current_Map),
    fill_dp_loop(ProcessedGroups_Array, N, I + 1, NewDP_Current_Map).

fill_dp_inner_loop(_ProcessedGroups_Array, I, _SizeI, _CharI, I, DP_Current_Map) -> DP_Current_Map; % Reached I, stop
fill_dp_inner_loop(ProcessedGroups_Array, I, SizeI, CharI, J, DP_Current_Map) ->
    {SizeJ, CharJ} = array:get(J, ProcessedGroups_Array), % O(1)

    IsUnequal = (SizeJ =/= SizeI) orelse (SizeJ == SizeI andalso CharJ =/= CharI),

    {PrevLen, _PrevPrevIdx} = maps:get(J, DP_Current_Map), % O(log N)
    {CurrentLen, _CurrentPrevIdx} = maps:get(I, DP_Current_Map), % O(log N)

    NewDP_Current_Map = if
        IsUnequal andalso (PrevLen + 1 > CurrentLen) ->
            maps:put(I, {PrevLen + 1, J}, DP_Current_Map); % O(log N)
        true ->
            DP_Current_Map
    end,
    fill_dp_inner_loop(ProcessedGroups_Array, I, SizeI, CharI, J + 1, NewDP_Current_Map).

find_max_len_and_idx(DP_Final_Map, N) ->
    find_max_len_and_idx_loop(DP_Final_Map, N, 0, {0, -1}).

find_max_len_and_idx_loop(_DP_Final_Map, N, N, Result) -> Result;
find_max_len_and_idx_loop(DP_Final_Map, N, CurrentIdx, {CurrentMaxLen, CurrentLastIdx}) ->
    {Len, _PrevIdx} = maps:get(CurrentIdx, DP_Final_Map), % O(log N)
    if
        Len > CurrentMaxLen ->
            find_max_len_and_idx_loop(DP_Final_Map, N, CurrentIdx + 1, {Len, CurrentIdx});
        true ->
            find_max_len_and_idx_loop(DP_Final_Map, N, CurrentIdx + 1, {CurrentMaxLen, CurrentLastIdx})
    end.

reconstruct_path(_DP_Final_Map, -1, Acc) -> Acc;
reconstruct_path(DP_Final_Map, CurrentIdx, Acc) ->
    {_Len, PrevIdx} = maps:get(CurrentIdx, DP_Final_Map), % O(log N)
    reconstruct_path(DP_Final_Map, PrevIdx, [CurrentIdx | Acc]).