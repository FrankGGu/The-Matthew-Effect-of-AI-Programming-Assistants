-module(solution).
-export([min_flips/1]).

min_flips(Grid) ->
    N = length(Grid),
    Grid1 = lists:map(fun(Row) -> lists:map(fun(X) -> case X of $0 -> 0; $1 -> 1 end end, Row) end, Grid),
    MinFlips = min_flips_helper(Grid1, 0, N, N),
    MinFlips.

min_flips_helper(Grid, Row, N, M) when Row >= div(N, 2) -> 
    0;
min_flips_helper(Grid, Row, N, M) ->
    Row1 = N - Row - 1,
    Flips = lists:sum(lists:map(fun({A, B}) -> if A == B -> 0; true -> 1 end end, lists:zip(Grid(Row), Grid(Row1)))),
    if Flips rem 2 == 0 -> 
        Min = min_flips_helper(Grid, Row + 1, N, M);
    true -> 
        Min = Flips + min_flips_helper(Grid, Row + 1, N, M)
    end,
    Min.