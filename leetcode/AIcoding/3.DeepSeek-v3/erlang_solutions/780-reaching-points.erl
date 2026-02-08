-spec reaching_points(Sx :: integer(), Sy :: integer(), Tx :: integer(), Ty :: integer()) -> boolean().
reaching_points(Sx, Sy, Tx, Ty) ->
    while_loop(Sx, Sy, Tx, Ty).

while_loop(Sx, Sy, Tx, Ty) when Tx < Sx orelse Ty < Sy ->
    false;
while_loop(Sx, Sy, Tx, Ty) when Tx > Ty ->
    if
        Ty > Sy -> while_loop(Sx, Sy, Tx rem Ty, Ty);
        Ty == Sy -> (Tx - Sx) rem Ty == 0
    end;
while_loop(Sx, Sy, Tx, Ty) when Ty > Tx ->
    if
        Tx > Sx -> while_loop(Sx, Sy, Tx, Ty rem Tx);
        Tx == Sx -> (Ty - Sy) rem Tx == 0
    end;
while_loop(Sx, Sy, Tx, Ty) ->
    Tx == Sx andalso Ty == Sy.