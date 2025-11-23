-module(count_substrings).
-export([count_substrings/2]).

count_substrings(S, T) ->
    count_substrings(S, T, 0).

count_substrings(S, T, Acc) ->
    SLen = length(S),
    TLen = length(T),
    count_substrings(S, T, SLen, TLen, 0, Acc).

count_substrings(_S, _T, 0, _TLen, _I, Acc) ->
    Acc;
count_substrings(_S, _T, _SLen, 0, _I, Acc) ->
    Acc;
count_substrings(S, T, SLen, TLen, I, Acc) ->
    count_substrings_helper(S, T, SLen, TLen, I, 0, Acc1),
    count_substrings(S, T, SLen, TLen, I + 1, Acc1),
    Acc1 = Acc + count_diff_by_one(S, T, I).

count_diff_by_one(S, T, I) ->
    count_diff_by_one(S, T, I, 0, 0).

count_diff_by_one(_S, _T, _I, J, Count) when J >= length(_T) ->
    Count;
count_diff_by_one(_S, _T, _I, _J, Count) when _I >= length(_S) ->
    Count;
count_diff_by_one(S, T, I, J, Count) ->
    count_diff_by_one_helper(S, T, I, J, 0, 0, Count).

count_diff_by_one_helper(_S, _T, _I, _J, _K, Diff, Count) when _I + _K > length(_S) -1 ->
    Count;
count_diff_by_one_helper(_S, _T, _I, _J, _K, Diff, Count) when _J + _K > length(_T) -1 ->
    Count;
count_diff_by_one_helper(S, T, I, J, K, Diff, Count) ->
    SChar = lists:nth(I + K + 1, S),
    TChar = lists:nth(J + K + 1, T),
    case SChar =:= TChar of
        true ->
            count_diff_by_one_helper(S, T, I, J, K + 1, Diff, Count);
        false ->
            case Diff < 1 of
                true ->
                    count_diff_by_one_helper(S, T, I, J, K + 1, Diff + 1, Count);
                false ->
                    Count
            end
    end.

count_substrings_helper(_S, _T, _SLen, _TLen, _I, _J, Acc) when _I >= _SLen ->
    Acc;
count_substrings_helper(_S, _T, _SLen, _TLen, _I, _J, Acc) when _J >= _TLen ->
    Acc;
count_substrings_helper(_S, _T, _SLen, _TLen, _I, _J, Acc) ->
    count_substrings_helper(_S, _T, _SLen, _TLen, _I + 1, _J, Acc),
    count_substrings_helper(_S, _T, _SLen, _TLen, _I, _J + 1, Acc).