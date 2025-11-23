-module(solution).
-export([furthest_building/3]).

furthest_building(Buildings, Brick, Ladder) ->
    furthest_building(Buildings, Brick, Ladder, 0, 0).

furthest_building([], _, _, MaxIndex, _) -> MaxIndex;
furthest_building([_], _, _, MaxIndex, _) -> MaxIndex;
furthest_building([H1, H2 | T], Brick, Ladder, MaxIndex, CurrentHeight) ->
    if
        H2 - H1 =< 0 -> 
            furthest_building([H2 | T], Brick, Ladder, MaxIndex + 1, H2);
        H2 - H1 =< Brick ->
            furthest_building([H2 | T], Brick - (H2 - H1), Ladder, MaxIndex + 1, H2);
        Ladder > 0 ->
            furthest_building([H2 | T], Brick, Ladder - 1, MaxIndex + 1, H2);
        true ->
            MaxIndex
    end.