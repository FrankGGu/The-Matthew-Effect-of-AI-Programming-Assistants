-module(solution).
-export([count_good_numbers/1]).

count_good_numbers(N) ->
    count_good_numbers(N, 0).

count_good_numbers(0, Count) ->
    Count;
count_good_numbers(N, Count) ->
    Num = N - 1,
    case is_good(Num) of
        true -> count_good_numbers(N - 1, Count + 1);
        false -> count_good_numbers(N - 1, Count)
    end.

is_good(Num) ->
    Digits = integer_to_list(Num),
    Length = length(Digits),
    case Length rem 2 of
        0 -> is_even(Digits);
        _ -> false
    end.

is_even([]) ->
    true;
is_even([H|T]) ->
    case lists:all(fun(D) -> D == H end, T) of
        true -> is_even([]);
        false -> false
    end.