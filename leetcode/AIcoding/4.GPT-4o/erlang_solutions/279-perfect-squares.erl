-spec num_squares(N :: integer()) -> integer().
num_squares(N) when N < 4 -> N;
num_squares(N) -> num_squares_helper(N, 1, []).

-spec num_squares_helper(N :: integer(), Current :: integer(), Seen :: [integer()]) -> integer().
num_squares_helper(N, Current, Seen) when Current * Current > N -> length(Seen);
num_squares_helper(N, Current, Seen) ->
    NewValue = N - Current * Current,
    if
        NewValue == 0 -> length(Seen) + 1;
        lists:member(NewValue, Seen) -> num_squares_helper(N, Current + 1, Seen);
        true -> num_squares_helper(NewValue, 1, [NewValue | Seen])
    end.
