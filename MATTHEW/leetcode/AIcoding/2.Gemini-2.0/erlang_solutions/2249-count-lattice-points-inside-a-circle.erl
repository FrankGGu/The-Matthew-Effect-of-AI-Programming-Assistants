-module(count_lattice_points).
-export([countLatticePoints/1]).

countLatticePoints(Circles) ->
    count_points(Circles, sets:new()).

count_points([], Acc) ->
    sets:size(Acc);
count_points([Circle|Rest], Acc) ->
    count_points(Rest, add_points(Circle, Acc)).

add_points([X, Y, R], Acc) ->
    add_points_helper(X, Y, R, X - R, X + R, Y - R, Y + R, Acc).

add_points_helper(X, Y, R, Xmin, Xmax, Ymin, Ymax, Acc) ->
    add_points_loop(Xmin, Xmax, Ymin, Ymax, X, Y, R, Acc).

add_points_loop(Xmin, Xmax, Ymin, Ymax, X, Y, R, Acc) ->
    add_points_x_loop(Xmin, Xmax, Ymin, Ymax, X, Y, R, Xmin, Acc).

add_points_x_loop(Xmin, Xmax, Ymin, Ymax, X, Y, R, CurX, Acc) ->
    case CurX > Xmax of
        true ->
            Acc;
        false ->
            add_points_y_loop(Xmin, Xmax, Ymin, Ymax, X, Y, R, CurX, Ymin, Acc)
    end.

add_points_y_loop(Xmin, Xmax, Ymin, Ymax, X, Y, R, CurX, CurY, Acc) ->
    case CurY > Ymax of
        true ->
            add_points_x_loop(Xmin, Xmax, Ymin, Ymax, X, Y, R, CurX + 1, Acc);
        false ->
            DistSq = (CurX - X) * (CurX - X) + (CurY - Y) * (CurY - Y),
            case DistSq =< R * R of
                true ->
                    add_points_y_loop(Xmin, Xmax, Ymin, Ymax, X, Y, R, CurX, CurY + 1, sets:add({CurX, CurY}, Acc));
                false ->
                    add_points_y_loop(Xmin, Xmax, Ymin, Ymax, X, Y, R, CurX, CurY + 1, Acc)
            end
    end.