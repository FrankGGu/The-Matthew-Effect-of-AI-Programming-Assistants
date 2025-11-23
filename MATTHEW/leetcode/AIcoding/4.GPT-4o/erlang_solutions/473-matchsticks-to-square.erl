-module(solution).
-export([makesquare/1]).

%% Main function to check if we can form a square with the matchsticks.
-spec makesquare([integer()]) -> boolean().
makesquare(Matchsticks) ->
    TotalLength = lists:sum(Matchsticks),
    %% If the total length is not divisible by 4, we cannot form a square.
    if
        TotalLength rem 4 /= 0 -> false;
        true -> 
            SideLength = TotalLength div 4,
            %% Sort the matchsticks in descending order to optimize the backtracking.
            SortedMatchsticks = lists:sort(fun(X, Y) -> Y < X end, Matchsticks),
            %% Start the backtracking process to try and form the square.
            can_form_square(SortedMatchsticks, [0, 0, 0, 0], SideLength)
    end.

%% Helper function to attempt forming the square using backtracking.
-spec can_form_square([integer()], [integer()], integer()) -> boolean().
can_form_square([], Sides, _) -> 
    %% If no matchsticks are left, check if all sides are equal to the target side length.
    Sides == [_, _, _, _] andalso lists:all(fun(X) -> X == hd(Sides) end, Sides);
can_form_square([Stick | Rest], Sides, SideLength) ->
    %% Try placing the current stick on each side and recursively check if a valid solution exists.
    try_place_on_side(Stick, Rest, Sides, SideLength, 0).

%% Try placing a matchstick on one of the 4 sides and check if it's valid.
-spec try_place_on_side(integer(), [integer()], [integer()], integer(), integer()) -> boolean().
try_place_on_side(_, [], _, _, _) -> false;
try_place_on_side(Stick, [Side | Rest], Sides, SideLength, Index) when Side + Stick > SideLength -> 
    %% If adding the stick exceeds the side length, skip this side.
    try_place_on_side(Stick, Rest, Sides, SideLength, Index + 1);
try_place_on_side(Stick, [Side | Rest], Sides, SideLength, Index) when Side + Stick =< SideLength ->
    %% Place the stick on this side, and continue with the next matchstick.
    NewSides = lists:replace_at(Sides, Index, Side + Stick),
    can_form_square(Rest, NewSides, SideLength).
