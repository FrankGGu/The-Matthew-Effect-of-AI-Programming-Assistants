-spec count_numbers_with_non_decreasing_digits(N :: integer()) -> integer().
count_numbers_with_non_decreasing_digits(N) ->
    count(1, 0, N).

count(Start, Sum, N) when Start > N ->
    Sum + 1;
count(Start, Sum, N) ->
    case is_non_decreasing(Start) of
        true -> count(Start + 1, Sum + 1, N);
        false -> count(Start + 1, Sum, N)
    end.

is_non_decreasing(Number) ->
    Digits = integer_to_list(Number),
    is_non_decreasing_digits(Digits).

is_non_decreasing_digits([_]) -> true;
is_non_decreasing_digits([A, B | Rest]) ->
    case A =< B of
        true -> is_non_decreasing_digits([B | Rest]);
        false -> false
    end.