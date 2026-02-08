-module(solution).
-export([decodeAtIndex/2]).

decodeAtIndex(S, K) ->
    S_list = string:to_list(S),
    TotalLen = calculate_total_length(S_list),
    [find_kth_char(lists:reverse(S_list), K, TotalLen)].

calculate_total_length(S_list) ->
    lists:foldl(fun(Char, AccLen) ->
        if Char >= $a andalso Char <= $z ->
            AccLen + 1;
           Char >= $2 andalso Char <= $9 ->
            AccLen * (Char - $0)
        end
    end, 0, S_list).

find_kth_char([Char | Rest], K, CurrentLen) ->
    if Char >= $a andalso Char <= $z ->
        if K == CurrentLen ->
            Char
        else
            find_kth_char(Rest, K, CurrentLen - 1)
        end;
       Char >= $2 andalso Char <= $9 ->
        Digit = Char - $0,
        NewLen = CurrentLen div Digit,
        NewK = (K - 1) rem NewLen + 1,
        find_kth_char(Rest, NewK, NewLen)
    end.