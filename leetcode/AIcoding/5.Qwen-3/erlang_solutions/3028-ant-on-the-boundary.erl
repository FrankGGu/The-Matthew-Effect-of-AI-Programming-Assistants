-module(ant_on_the_boundary).
-export([fsm/1]).

fsm(A) ->
    fsm(A, 0, 0).

fsm([], _, _) ->
    0;
fsm([H | T], Pos, Count) ->
    NewPos = Pos + H,
    case NewPos of
        0 ->
            fsm(T, NewPos, Count + 1);
        _ ->
            fsm(T, NewPos, Count)
    end.