-module(solution).
-export([solution_init_/1, solution_pick/0]).

-define(MAX_CALLS, 10000).

%% Initialize the Solution with the given rectangles.
-spec solution_init_([[integer()]]) -> any().
solution_init_(Rects) ->
    %% Calculate the area of each rectangle and store them with their corners.
    RectsWithArea = lists:map(fun([X1, Y1, X2, Y2]) -> 
                                   Area = (X2 - X1 + 1) * (Y2 - Y1 + 1),
                                   {Area, {X1, Y1, X2, Y2}}
                               end, Rects),
    %% Store the cumulative area.
    CumulativeAreas = lists:foldl(fun({Area, Rect}, Acc) ->
                                       case Acc of
                                           [] -> [{Area, Rect}];
                                           [{LastArea, _LastRect}|Tail] -> 
                                               [{LastArea + Area, Rect}|Tail]
                                       end
                                   end, [], RectsWithArea),
    %% Store the cumulative areas for easy access during pick.
    %% Set the cumulative areas as a state.
    put(state, CumulativeAreas).

%% Pick a random point from one of the rectangles.
-spec solution_pick() -> [integer()].
solution_pick() ->
    %% Retrieve the cumulative areas.
    CumulativeAreas = get(state),
    %% Select a random area (based on the cumulative sum).
    RandomArea = random:uniform(lists:last(CumulativeAreas)),
    %% Find the selected rectangle by searching within the cumulative areas.
    SelectedRectangle = find_rectangle(CumulativeAreas, RandomArea),
    %% Pick a random point inside the selected rectangle.
    pick_random_point(SelectedRectangle).

%% Find the rectangle that contains the selected random area.
find_rectangle([{Area, Rect}|_Tail], RandomArea) when RandomArea =< Area -> Rect;
find_rectangle([{Area, Rect}|Tail], RandomArea) -> find_rectangle(Tail, RandomArea).

%% Pick a random point inside the given rectangle.
pick_random_point([X1, Y1, X2, Y2]) ->
    X = random:uniform(X2 - X1 + 1) + X1 - 1,
    Y = random:uniform(Y2 - Y1 + 1) + Y1 - 1,
    [X, Y].

