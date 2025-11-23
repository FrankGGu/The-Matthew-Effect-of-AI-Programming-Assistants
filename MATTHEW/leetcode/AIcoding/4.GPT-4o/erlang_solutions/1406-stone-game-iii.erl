-module(solution).
-export([stone_game_iii/1]).

stone_game_iii(Piles) ->
    N = length(Piles),
    DP = lists:duplicate(N + 1, -1),
    game(Piles, DP, 0).

game(Piles, DP, Index) when Index >= length(Piles) ->
    0;
game(Piles, DP, Index) ->
    case lists: nth(Index + 1, DP) of
        -1 ->
            MaxScore = lists:foldl(fun(X, Acc) ->
                NextIndex = Index + X,
                if
                    NextIndex >= length(Piles) -> Acc;
                    true -> 
                        Score = sum(Piles, Index, NextIndex),
                        Acc1 = Score - game(Piles, DP, NextIndex),
                        max(Acc, Acc1)
                end
            end, -1, [1, 2, 3]),
            DP1 = lists:replace_at(Index + 1, MaxScore, DP),
            lists:nth(Index + 1, DP1);
        Score -> Score
    end.

sum(Piles, Start, End) ->
    lists:sum(lists:sublist(Piles, Start + 1, End - Start)).