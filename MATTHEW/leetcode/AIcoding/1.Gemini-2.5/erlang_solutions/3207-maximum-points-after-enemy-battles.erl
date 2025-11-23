-module(solution).
-export([max_points_after_enemy_battles/2]).

max_points_after_enemy_battles(Enemies, InitialArmor) ->
    SortedEnemies = lists:sort(Enemies),
    case SortedEnemies of
        [] -> 0;
        _ ->
            max_points_loop(SortedEnemies, lists:reverse(SortedEnemies), InitialArmor, 0, 0)
    end.

max_points_loop([], _RightList, _Armor, _Points, MaxPoints) ->
    MaxPoints;
max_points_loop(LeftList, RightList, Armor, Points, MaxPoints) ->
    Weakest = hd(LeftList),
    Strongest = hd(RightList),

    if
        Armor >= Weakest ->
            NewArmor = Armor - Weakest,
            NewPoints = Points + Weakest,
            NewMaxPoints = max(MaxPoints, NewPoints),
            max_points_loop(tl(LeftList), RightList, NewArmor, NewPoints, NewMaxPoints);
        Points > 0 and Weakest /= Strongest ->
            NewArmor = Armor + Strongest,
            NewPoints = Points - 1,
            max_points_loop(LeftList, tl(RightList), NewArmor, NewPoints, MaxPoints);
        true ->
            MaxPoints
    end.