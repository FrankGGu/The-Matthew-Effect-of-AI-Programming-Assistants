-module(winner_of_array_game).
-export([solve/1]).

solve(Nums) ->
    solve(Nums, 0, 1).

solve([H|T], I, J) when H > lists:nth(J, Nums) ->
    H;
solve([H|T], I, J) ->
    solve(T, J, I + 1).