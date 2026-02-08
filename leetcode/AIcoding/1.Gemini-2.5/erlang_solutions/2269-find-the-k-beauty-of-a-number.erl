-module(solution).
-export([divisorSubstrings/2]).

divisorSubstrings(Num, K) ->
    NumStr = integer_to_list(Num),
    StrLen = length(NumStr),
    count_beauty(Num, K, NumStr, StrLen, 0, 0).

count_beauty(_Num, _K, _NumStr, StrLen, Index, Count) when Index > StrLen - _K ->
    Count;
count_beauty(Num, K, NumStr, StrLen, Index, AccCount) ->
    SubStr = lists:sublist(NumStr, Index + 1, K),
    SubInt = list_to_integer(SubStr),
    NewAccCount =
        if
            SubInt /= 0 andalso (Num rem SubInt == 0) ->
                AccCount + 1;
            true ->
                AccCount
        end,
    count_beauty(Num, K, NumStr, StrLen, Index + 1, NewAccCount).