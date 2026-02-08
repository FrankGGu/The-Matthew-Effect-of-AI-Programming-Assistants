-spec last_remaining(N :: integer()) -> integer().
last_remaining(N) ->
    last_remaining(N, true).

last_remaining(1, _) -> 1;
last_remaining(N, true) ->
    2 * last_remaining(N div 2, false);
last_remaining(N, false) ->
    2 * last_remaining(N div 2, true) - 1 + N rem 2.