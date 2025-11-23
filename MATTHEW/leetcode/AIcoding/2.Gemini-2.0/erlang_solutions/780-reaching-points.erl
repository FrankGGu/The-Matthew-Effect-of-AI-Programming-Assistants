-module(reaching_points).
-export([reaching_points/4]).

reaching_points(Sx, Sy, Tx, Ty) ->
    reaching_points_helper(Sx, Sy, Tx, Ty).

reaching_points_helper(Sx, Sy, Tx, Ty) ->
    if
        Tx < Sx orelse Ty < Sy ->
            false;
        Tx == Sx andalso Ty == Sy ->
            true;
        Tx == Sx ->
            (Ty - Sy) rem Sx == 0;
        Ty == Sy ->
            (Tx - Sx) rem Sy == 0;
        true ->
            if
                Tx > Ty ->
                    reaching_points_helper(Sx, Sy, Tx rem Ty, Ty);
                true ->
                    reaching_points_helper(Sx, Sy, Tx, Ty rem Tx)
            end
    end.