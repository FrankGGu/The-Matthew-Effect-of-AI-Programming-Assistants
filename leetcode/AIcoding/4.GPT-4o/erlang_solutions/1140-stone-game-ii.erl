-module(solution).
-export([stone_game_ii/1]).

stone_game_ii(Piles) ->
    N = length(Piles),
    Piles2 = lists:foldr(fun(X, Acc) -> Acc ++ [X + (lists:last(Acc) orelse 0)] end, [0], Piles),
    stone_game_ii_helper(Piles2, 1, 0, N).

stone_game_ii_helper(Piles, M, Start, N) ->
    case Start >= N of
        true -> 0;
        false ->
            MaxScore = lists:max([stone_game_ii_helper(Piles, max(M, X), Start + X, N) || X <- lists:seq(1, min(2 * M, N - Start))]),
            Total = lists:last(Piles) - lists:nth(Start, Piles),
            Total - MaxScore
    end.