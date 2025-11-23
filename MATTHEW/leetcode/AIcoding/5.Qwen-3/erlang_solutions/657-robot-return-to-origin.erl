-module(robot_return_to_origin).
-export([judge_route/1]).

judge_route(Routes) ->
    {X, Y} = lists:foldl(fun move/2, {0, 0}, Routes),
    X == 0 andalso Y == 0.

move($U, {X, Y}) -> {X, Y + 1};
move($D, {X, Y}) -> {X, Y - 1};
move($L, {X, Y}) -> {X - 1, Y};
move($R, {X, Y}) -> {X + 1, Y}.