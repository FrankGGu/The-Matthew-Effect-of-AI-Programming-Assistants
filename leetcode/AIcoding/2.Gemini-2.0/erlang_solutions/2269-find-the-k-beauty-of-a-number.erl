-module(k_beauty).
-export([k_beauty/2]).

k_beauty(N, K) ->
    k_beauty(integer_to_list(N), K, 0).

k_beauty(Digits, K, Count) ->
    Len = length(Digits),
    if Len < K ->
        Count
    else ->
        SubDigits = lists:sublist(Digits, 1, K),
        SubNum = list_to_integer(SubDigits),
        NewCount = case SubNum =/= 0 andalso (list_to_integer(Digits) rem SubNum) == 0 of
            true -> Count + 1;
            false -> Count
        end,
        k_beauty(tl(Digits), K, NewCount)
    end.