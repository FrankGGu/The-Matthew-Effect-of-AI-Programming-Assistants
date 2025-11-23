-spec next_greater_element(N :: integer()) -> integer().
next_greater_element(N) ->
    Digits = integer_to_list(N),
    case find_pivot(Digits) of
        -1 -> -1;
        Pivot ->
            {Prefix, Suffix} = lists:split(Pivot, Digits),
            PivotDigit = lists:nth(Pivot + 1, Digits),
            SwapIndex = find_swap_index(PivotDigit, Suffix),
            NewPrefix = Prefix ++ [lists:nth(SwapIndex + 1, Suffix)],
            NewSuffix = lists:sublist(Suffix, SwapIndex) ++ [PivotDigit] ++ lists:nthtail(SwapIndex + 1, Suffix),
            NewDigits = NewPrefix ++ lists:reverse(NewSuffix),
            NewNum = list_to_integer(NewDigits),
            case NewNum > N andalso NewNum =< 2147483647 of
                true -> NewNum;
                false -> -1
            end
    end.

find_pivot(Digits) ->
    find_pivot(Digits, length(Digits) - 1).

find_pivot(Digits, I) when I > 0 ->
    case lists:nth(I, Digits) < lists:nth(I + 1, Digits) of
        true -> I - 1;
        false -> find_pivot(Digits, I - 1)
    end;
find_pivot(_, _) -> -1.

find_swap_index(PivotDigit, Suffix) ->
    find_swap_index(PivotDigit, Suffix, 0, length(Suffix) - 1).

find_swap_index(PivotDigit, Suffix, I, Len) when I =< Len ->
    case lists:nth(Len - I + 1, Suffix) > PivotDigit of
        true -> Len - I;
        false -> find_swap_index(PivotDigit, Suffix, I + 1, Len)
    end.