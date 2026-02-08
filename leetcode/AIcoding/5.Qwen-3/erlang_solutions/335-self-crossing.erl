-module(self_crossing).
-export([is_self_crossing/1]).

is_self_crossing(Points) ->
    N = length(Points),
    case N < 4 of
        true -> false;
        false ->
            is_self_crossing(Points, 3)
    end.

is_self_crossing(_, I) when I >= 0 ->
    case I >= 3 of
        true ->
            [A,B,C,D] = lists:sublist(Points, I-3+1, 4),
            X1 = B#point.x - A#point.x,
            Y1 = B#point.y - A#point.y,
            X2 = C#point.x - B#point.x,
            Y2 = C#point.y - B#point.y,
            X3 = D#point.x - C#point.x,
            Y3 = D#point.y - C#point.y,
            if
                (X1 == 0 andalso Y2 == 0 andalso X3 == 0) -> false;
                (Y1 == 0 andalso X2 == 0 andalso Y3 == 0) -> false;
                true ->
                    % Check for crossing with previous lines
                    check_crossing(A, B, C, D)
            end;
        false -> false
    end.

check_crossing(A, B, C, D) ->
    % Line AB
    % Line BC
    % Line CD
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
    % Check if AB crosses BC
    % Check if AB crosses CD
    % Check if BC crosses CD
   ......
    % This is a simplified version for demonstration, actual code would need proper line intersection logic.
    false.