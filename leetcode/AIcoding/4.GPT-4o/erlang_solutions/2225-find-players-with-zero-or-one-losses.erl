-module(solution).
-export([find_players/1]).

find_players(Matches) ->
    Counts = lists:foldl(fun({Winner, Loser}, Acc) ->
        maps:update_with(Winner, fun(X) -> X + 0 end, Acc, 0) ++
        maps:update_with(Loser, fun(X) -> X + 1 end, Acc, 0)
    end, #{}, Matches),
    PlayersWithZeroLosses = maps:fold(fun({Player, Losses}, Acc) ->
        case Losses of
            0 -> [Player | Acc];
            _ -> Acc
        end
    end, [], Counts),
    PlayersWithOneLoss = maps:fold(fun({Player, Losses}, Acc) ->
        case Losses of
            1 -> [Player | Acc];
            _ -> Acc
        end
    end, [], Counts),
    [lists:sort(PlayersWithZeroLosses), lists:sort(PlayersWithOneLoss)].