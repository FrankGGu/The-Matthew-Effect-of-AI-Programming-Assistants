-spec find_the_winner(N :: integer(), K :: integer()) -> integer().
find_the_winner(N, K) ->
    solve(N, K).

solve(1, _) -> 1;
solve(N, K) ->
    (solve(N - 1, K) + K - 1) rem N + 1.