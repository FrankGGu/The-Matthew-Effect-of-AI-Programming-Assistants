-module(solution).
-export([nearest_valid_point/3]).

nearest_valid_point(X, Y, Points) ->
    nearest_valid_point(X, Y, Points, -1, 1.0e9, 0).

nearest_valid_point(_, _, [], Index, MinDistance, _) when MinDistance =:= 1.0e9 ->
    -1;
nearest_valid_point(X, Y, [{X1, Y1} | T], Index, MinDistance, Count) ->
    case X1 =:= X orelse Y1 =:= Y of
        true ->
            Distance = abs(X1 - X) + abs(Y1 - Y),
            case Distance < MinDistance of
                true -> nearest_valid_point(X, Y, T, Count, Distance, Count);
                false -> nearest_valid_point(X, Y, T, Index, MinDistance, Count + 1)
            end;
        false -> nearest_valid_point(X, Y, T, Index, MinDistance, Count + 1)
    end.