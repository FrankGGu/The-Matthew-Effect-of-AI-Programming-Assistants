-module(max_points_after_enemy_battles).
-export([maxPoints/1]).

maxPoints(Enemies) ->
    maxPoints(Enemies, 0, 0).

maxPoints([], Points, _) ->
    Points;
maxPoints([Enemy | Rest], Points, LastUsed) ->
    EnemyPoints = element(1, Enemy),
    EnemyType = element(2, Enemy),
    case EnemyType of
        1 ->
            if
                LastUsed == 1 ->
                    maxPoints(Rest, Points, 1);
                true ->
                    maxPoints(Rest, Points + EnemyPoints, 1)
            end;
        2 ->
            if
                LastUsed == 2 ->
                    maxPoints(Rest, Points, 2);
                true ->
                    maxPoints(Rest, Points + EnemyPoints, 2)
            end;
        3 ->
            if
                LastUsed == 3 ->
                    maxPoints(Rest, Points, 3);
                true ->
                    maxPoints(Rest, Points + EnemyPoints, 3)
            end
    end.