-spec solve_n_queens(N :: integer()) -> [[unicode:unicode_binary()]].
solve_n_queens(N) ->
    solve_n_queens(N, [], []).

solve_n_queens(0, Acc, Result) -> 
    lists:reverse(Acc) ++ [lists:reverse(Result)];
solve_n_queens(N, Acc, Result) ->
    solve_n_queens(N-1, Acc, [generate_board(N, Result) | Result]).

generate_board(N, Result) -> 
    lists:map(fun(X) -> lists:duplicate(N, '.') end, Result).
