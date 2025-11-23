-module(solution).

-export([shortest_string_that_contains_three_strings/3]).

-spec shortest_string_that_contains_three_strings(S1 :: unicode:unicode_binary(), S2 :: unicode:unicode_binary(), S3 :: unicode:unicode_binary()) -> unicode:unicode_binary().
shortest_string_that_contains_three_strings(S1, S2, S3) ->
    Permutations = [[S1, S2, S3], [S1, S3, S2],
                    [S2, S1, S3], [S2, S3, S1],
                    [S3, S1, S2], [S3, S2, S1]],

    lists:foldl(fun(P, Acc) ->
                    [A, B, C] = P,
                    CurrentResult = merge_three(A, B, C),
                    compare_and_update(CurrentResult, Acc)
                end, S1 ++ S2 ++ S3, Permutations).

merge_three(S_A, S_B, S_C) ->
    MergedAB = merge_two(S_A, S_B),
    merge_two(MergedAB, S_C).

merge_two(S1, S2) ->
    Candidate = S1 ++ S2,

    Best = case string:str(S1, S2) of
               0 -> Candidate;
               _ -> compare_and_update(S1, Candidate)
           end,

    Best2 = case string:str(S2, S1) of
                0 -> Best;
                _ -> compare_and_update(S2, Best)
            end,

    Len1 = byte_size(S1),
    Len2 = byte_size(S2),

    OverlapAB = find_max_overlap(S1, S2, Len1, Len2),
    CombinedAB = S1 ++ binary:part(S2, OverlapAB, Len2 - OverlapAB),
    Best3 = compare_and_update(CombinedAB, Best2),

    OverlapBA = find_max_overlap(S2, S1, Len2, Len1),
    CombinedBA = S2 ++ binary:part(S1, OverlapBA, Len1 - OverlapBA),
    compare_and_update(CombinedBA, Best3).

find_max_overlap(S1, S2, Len1, Len2) ->
    Limit = min(Len1, Len2),
    find_max_overlap_loop(S1, S2, Len1, Len2, Limit).

find_max_overlap_loop(_S1, _S2, _Len1, _Len2, 0) ->
    0;
find_max_overlap_loop(S1, S2, Len1, Len2, K) ->
    SuffixS1 = binary:part(S1, Len1 - K, K),
    PrefixS2 = binary:part(S2, 0, K),

    if SuffixS1 == PrefixS2 ->
        K;
    true ->
        find_max_overlap_loop(S1, S2, Len1, Len2, K - 1)
    end.

compare_and_update(NewStr, CurrentBest) ->
    NewLen = byte_size(NewStr),
    CurrentLen = byte_size(CurrentBest),

    if NewLen < CurrentLen ->
        NewStr;
    NewLen == CurrentLen ->
        if NewStr < CurrentBest ->
            NewStr;
        true ->
            CurrentBest
        end;
    true ->
        CurrentBest
    end.