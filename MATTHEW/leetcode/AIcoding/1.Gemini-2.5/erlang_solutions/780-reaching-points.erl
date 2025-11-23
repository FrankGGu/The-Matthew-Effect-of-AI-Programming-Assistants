-spec reaching_points(Sx :: integer(), Sy :: integer(), Tx :: integer(), Ty :: integer()) -> boolean().
reaching_points(Sx, Sy, Tx, Ty) ->
    reaching_points_recursive(Sx, Sy, Tx, Ty).

reaching_points_recursive(Sx, Sy, Tx, Ty) when Tx == Sx, Ty == Sy ->
    true;
reaching_points_recursive(Sx, Sy, Tx, Ty) when Tx < Sx; Ty < Sy ->
    false;
reaching_points_recursive(Sx, Sy, Tx, Ty) when Tx == Ty ->
    false;
reaching_points_recursive(Sx, Sy, Tx, Ty) when Tx > Ty ->
    if Ty == Sy ->
        (Tx >= Sx) andalso ((Tx - Sx) rem Sy == 0);
    true ->
        NextTx = if (Tx rem Ty) == 0 then Ty else (Tx rem Ty) end;
        if NextTx < Sx ->
            false;
        true ->
            reaching_points_recursive(Sx, Sy, NextTx, Ty)
        end
    end;
reaching_points_recursive(Sx, Sy, Tx, Ty) when Ty > Tx ->
    if Tx == Sx ->
        (Ty >= Sy) andalso ((Ty - Sy) rem Sx == 0);
    true ->
        NextTy = if (Ty rem Tx) == 0 then Tx else (Ty rem Tx) end;
        if NextTy < Sy ->
            false;
        true ->
            reaching_points_recursive(Sx, Sy, Tx, NextTy)
        end
    end.