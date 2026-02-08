-module(solution).
-export([check_inclusion/2]).

char_to_index(Char) -> Char - $a.

create_initial_counts() -> lists:duplicate(26, 0).

update_counts(Counts, Char, Delta) ->
    Index = char_to_index(Char),
    CurrentCount = lists:nth(Index + 1, Counts),
    lists:replace_nth(Index + 1, CurrentCount + Delta, Counts).

build_counts(String) ->
    lists:foldl(fun(Char, Acc) -> update_counts(Acc, Char, 1) end, create_initial_counts(), String).

build_counts_from_array_slice(Array, StartIdx, EndIdx) ->
    lists:foldl(fun(Idx, Acc) ->
                    Char = array:get(Idx, Array),
                    update_counts(Acc, Char, 1)
                end, create_initial_counts(), lists:seq(StartIdx, EndIdx)).

check_inclusion(S1, S2) ->
    Len1 = length(S1),
    Len2 = length(S2),

    if Len1 > Len2 ->
        false;
    true ->
        S1Counts = build_counts(S1),
        S2Array = array:from_list(S2),

        InitialWindowCounts = build_counts_from_array_slice(S2Array, 0, Len1 - 1),

        if S1Counts =:= InitialWindowCounts ->
            true;
        true ->
            slide_window_array(S1Counts, InitialWindowCounts, S2Array, 0, Len1, Len2 - 1)
        end
    end.

slide_window_array(S1Counts, CurrentWindowCounts, S2Array, LeftPtr, RightPtr, MaxS2Idx) ->
    if RightPtr > MaxS2Idx ->
        false;
    true ->
        CharToRemove = array:get(LeftPtr, S2Array),
        UpdatedWindowCounts1 = update_counts(CurrentWindowCounts, CharToRemove, -1),

        CharToAdd = array:get(RightPtr, S2Array),
        UpdatedWindowCounts2 = update_counts(UpdatedWindowCounts1, CharToAdd, 1),

        if S1Counts =:= UpdatedWindowCounts2 ->
            true;
        true ->
            slide_window_array(S1Counts, UpdatedWindowCounts2, S2Array, LeftPtr + 1, RightPtr + 1, MaxS2Idx)
        end
    end.