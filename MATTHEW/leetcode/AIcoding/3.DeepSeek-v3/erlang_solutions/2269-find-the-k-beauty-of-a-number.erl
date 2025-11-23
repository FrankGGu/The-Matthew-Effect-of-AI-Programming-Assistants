-spec divisor_substrings(Num :: integer(), K :: integer()) -> integer().
divisor_substrings(Num, K) ->
    S = integer_to_list(Num),
    Len = length(S),
    Count = 0,
    if 
        K > Len -> 0;
        true -> count_divisors(S, K, 0, 0, Len)
    end.

count_divisors(S, K, Index, Count, Len) when Index + K =< Len ->
    SubStr = string:substr(S, Index + 1, K),
    SubNum = list_to_integer(SubStr),
    if 
        SubNum =/= 0 andalso (Len =:= K orelse string:substr(S, Index + 1, 1) =/= "0") ->
            case list_to_integer(S) rem SubNum of
                0 -> count_divisors(S, K, Index + 1, Count + 1, Len);
                _ -> count_divisors(S, K, Index + 1, Count, Len)
            end;
        true -> count_divisors(S, K, Index + 1, Count, Len)
    end;
count_divisors(_, _, _, Count, _) -> Count.