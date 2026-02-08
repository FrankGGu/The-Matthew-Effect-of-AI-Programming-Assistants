-spec find_kth_number(N :: integer(), K :: integer()) -> integer().
find_kth_number(N, K) ->
    Len = 1,
    Count = 9,
    Start = 1,
    find_kth_number(N, K, Len, Count, Start).

find_kth_number(N, K, Len, Count, Start) ->
    if
        K > Len * Count ->
            find_kth_number(N, K - Len * Count, Len + 1, Count * 10, Start * 10);
        true ->
            Num = Start + (K - 1) div Len,
            if
                Num > N ->
                    find_kth_number(N, K - (N - Start + 1) * Len, Len + 1, Count * 10, Start * 10);
                true ->
                    Digit = integer_to_list(Num),
                    list_to_integer([lists:nth((K - 1) rem Len + 1, Digit)])
            end
    end.