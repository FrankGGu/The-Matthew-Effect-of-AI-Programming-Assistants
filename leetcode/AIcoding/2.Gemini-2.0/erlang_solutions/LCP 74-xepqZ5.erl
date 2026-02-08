-module(strongest_blessing).
-export([max_blessing/1]).

max_blessing(positions) ->
    max_blessing(positions, []).

max_blessing([], Acc) ->
    area(Acc);
max_blessing([H|T], Acc) ->
    A1 = max_blessing(T, Acc),
    A2 = max_blessing(T, [H|Acc]),
    max(A1, A2).

area([]) ->
    0;
area(Circles) ->
    area(Circles, []).

area([], Acc) ->
    total_area(Acc);
area([H|T], Acc) ->
    case is_overlap(H, Acc) of
        true ->
            area(T, Acc);
        false ->
            area(T, [H|Acc])
    end.

is_overlap({X1, Y1, R1}, Acc) ->
    is_overlap({X1, Y1, R1}, Acc, false).

is_overlap(_, [], Result) ->
    Result;
is_overlap({X1, Y1, R1}, [{X2, Y2, R2}|T], Result) ->
    Dist = math:sqrt(math:pow(X1 - X2, 2) + math:pow(Y1 - Y2, 2)),
    case Dist < R1 + R2 of
        true ->
            true;
        false ->
            is_overlap({X1, Y1, R1}, T, Result)
    end.

total_area([]) ->
    0;
total_area(Circles) ->
    lists:sum([area_of_circle(R) || {_, _, R} <- Circles]).

area_of_circle(R) ->
    math:pi() * math:pow(R, 2).

max(A, B) ->
    if A > B ->
        A;
    true ->
        B
    end.