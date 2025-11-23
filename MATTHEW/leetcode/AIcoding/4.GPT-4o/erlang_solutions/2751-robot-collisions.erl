-module(solution).
-export([robotCollisions/1]).

robotCollisions(Robots) ->
    robotCollisions(Robots, []).

robotCollisions([], Result) ->
    lists:reverse(Result);
robotCollisions([H|T], Acc) ->
    case H of
        {_, 'L'} -> robotCollisions(T, [H | Acc]);
        {_, 'R'} -> robotCollisions(T, handle_right(H, T, Acc));
    end.

handle_right(_, [], Acc) -> [H | Acc];
handle_right(Robot, [{Pos2, 'L'} | _] = T, Acc) when Pos2 > elem(Robot, 0) -> 
    handle_left(Robot, T, Acc);
handle_right(Robot, [{Pos2, 'R'} | T], Acc) when Pos2 > elem(Robot, 0) -> 
    handle_right(Robot, T, Acc);
handle_right(Robot, [{Pos2, 'R'} | T], Acc) when Pos2 < elem(Robot, 0) -> 
    handle_right(Robot, T, Acc);
handle_right(Robot, [{Pos2, 'L'} | T], Acc) when Pos2 < elem(Robot, 0) -> 
    handle_right(Robot, T, Acc);
handle_right(Robot, T, Acc) -> 
    [H | Acc].

handle_left(Robot, [{Pos, 'L'} | T], Acc) when Pos > elem(Robot, 0) ->
    handle_left(Robot, T, Acc);
handle_left(Robot, [{Pos, 'R'} | T], Acc) when Pos < elem(Robot, 0) ->
    handle_left(Robot, T, Acc);
handle_left(Robot, [{Pos, 'L'} | T], Acc) when Pos < elem(Robot, 0) ->
    handle_left(Robot, T, Acc);
handle_left(Robot, [], Acc) -> 
    [H | Acc].