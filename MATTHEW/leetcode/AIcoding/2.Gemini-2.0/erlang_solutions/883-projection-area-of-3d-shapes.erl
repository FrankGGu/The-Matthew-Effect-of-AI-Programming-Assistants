-module(projection_area).
-export([projection_area/1]).

projection_area(Grid) ->
    project(Grid, 0, 0, 0).

project([], Xy, Xz, Yz) ->
    Xy + Xz + Yz;
project([Row | Rest], Xy, Xz, Yz) ->
    {NewXy, NewXz, NewYz} = project_row(Row, 0, Xz, Yz, 0),
    project(Rest, Xy + NewXy, NewXz, NewYz).

project_row([], Xy, Xz, Yz, Max) ->
    {Xy, Xz + Max, Yz};
project_row([H | T], Xy, Xz, Yz, Max) ->
    NewXy = if H > 0 then Xy + 1 else Xy end,
    NewMax = if H > Max then H else Max end,
    project_row(T, NewXy, Xz, Yz + H, NewMax).