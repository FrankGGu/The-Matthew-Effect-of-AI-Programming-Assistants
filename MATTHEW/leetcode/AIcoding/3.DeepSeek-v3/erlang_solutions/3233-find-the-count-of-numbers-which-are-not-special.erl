-module(solution).
-export([count_special_numbers/1]).

count_special_numbers(N) ->
    count_special_numbers(N, 0).

count_special_numbers(0, Count) ->
    Count;
count_special_numbers(N, Count) ->
    case is_special(N) of
        false -> count_special_numbers(N - 1, Count + 1);
        true -> count_special_numbers(N - 1, Count)
    end.

is_special(N) ->
    Digits = integer_to_list(N),
    has_duplicate(Digits).

has_duplicate([]) ->
    false;
has_duplicate([H|T]) ->
    case lists:member(H, T) of
        true -> true;
        false -> has_duplicate(T)
    end.