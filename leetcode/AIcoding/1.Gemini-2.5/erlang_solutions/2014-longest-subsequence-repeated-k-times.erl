-module(solution).
-export([longestSubsequenceRepeatedK/2]).

longestSubsequenceRepeatedK(Text, K) ->
    TextBin = list_to_binary(Text),
    TextLen = byte_size(TextBin),

    UniqueChars = lists:sort(lists:usort(Text)),
    NumUniqueChars = length(UniqueChars),

    MaxLFromLen = TextLen div K,

    MaxLToSearch = 
        if NumUniqueChars == 0 -> 0;
           NumUniqueChars == 1 -> MaxLFromLen;
           true -> min(MaxLFromLen, 3)
        end,

    ResultBin = find_longest_s(MaxLToSearch, TextBin, K, UniqueChars),

    binary_to_list(ResultBin).

find_longest_s(MaxL, TextBin, K, UniqueChars) ->
    lists:foldl(fun(L, Acc) ->
        case Acc of
            <<>> ->
                case find_s_of_length(L, TextBin, K, UniqueChars) of
                    {found, S} -> S;
                    not_found -> <<>>
                end;
            _ -> Acc
        end
    end, <<>>, lists:seq(MaxL, 0, -1)).

find_s_of_length(TargetL, TextBin, K, UniqueChars) ->
    dfs([], 0, TargetL, TextBin, K, UniqueChars).

dfs(CurrentSReversed, CurrentLen, TargetL, TextBin, K, UniqueChars) ->
    if CurrentLen == TargetL ->
        S = list_to_binary(lists:reverse(CurrentSReversed)),
        if check_k_times(S, TextBin, K) ->
            {found, S};
        else
            not_found
        end;
    true ->
        lists:foldl(fun(Char, Acc) ->
                        case Acc of
                            {found, _} -> Acc;
                            not_found -> 
                                dfs([Char | CurrentSReversed], CurrentLen + 1, TargetL, TextBin, K, UniqueChars)
                        end
                    end, not_found, lists:reverse(UniqueChars))
    end.

check_k_times(SubBin, TextBin, K) ->
    SubLen = byte_size(SubBin),
    if SubLen == 0 ->
        true;
    true ->
        Count = count_subsequences_k_times_impl(SubBin, TextBin, K, 0, 0),
        Count == K
    end.

count_subsequences_k_times_impl(SubBin, TextBin, K, CurrentCount, StartIdx) ->
    if CurrentCount == K ->
        K;
    true ->
        case find_one_subsequence(SubBin, TextBin, StartIdx) of
            not_found -> CurrentCount;
            NextStartIdx ->
                count_subsequences_k_times_impl(SubBin, TextBin, K, CurrentCount + 1, NextStartIdx)
        end
    end.

find_one_subsequence(SubBin, TextBin, StartIdx) ->
    SubLen = byte_size(SubBin),
    TextLen = byte_size(TextBin),

    find_one_subsequence_impl(SubBin, TextBin, SubLen, TextLen, 0, StartIdx).

find_one_subsequence_impl(SubBin, TextBin, SubLen, TextLen, SubIdx, TextIdx) ->
    if SubIdx == SubLen ->
        TextIdx;
    elseif TextIdx == TextLen ->
        not_found;
    else
        SubChar = binary:at(SubBin, SubIdx),
        TextChar = binary:at(TextBin, TextIdx),
        if SubChar == TextChar ->
            find_one_subsequence_impl(SubBin, TextBin, SubLen, TextLen, SubIdx + 1, TextIdx + 1);
        else
            find_one_subsequence_impl(SubBin, TextBin, SubLen, TextLen, SubIdx, TextIdx + 1)
        end
    end.