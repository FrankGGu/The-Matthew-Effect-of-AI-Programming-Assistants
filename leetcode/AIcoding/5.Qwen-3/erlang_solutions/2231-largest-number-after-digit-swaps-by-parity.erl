-module(largest_number_after_digit_swaps_by_parity).
-export([largest_number/1]).

largest_number(N) ->
    Digits = integer_to_list(N),
    Sorted = lists:sort(Digits),
    case lists:usort(Sorted) of
        [H|T] when H == hd(Sorted) -> lists:reverse(Sorted);
        _ -> lists:reverse(Sorted)
    end.