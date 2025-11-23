-module(solution).
-export([programmable_robot/2]).

programmable_robot(Command, Obstacles) ->
    {FinalX, FinalY, PathSet} =
        lists:foldl(
            fun(C, {CurrentX, CurrentY, AccPathSet}) ->
                NewX = CurrentX,
                NewY = CurrentY,
                case C of
                    $U -> NewY = CurrentY + 1;
                    $R -> NewX = CurrentX + 1;
                    $D -> NewY = CurrentY - 1;
                    $L -> NewX = CurrentX - 1
                end,
                {NewX, NewY, sets:add({NewX, NewY}, AccPathSet)}
            end,
            {0, 0, sets:from_list([{0,0}])},
            Command
        ),

    FinalDx = FinalX,
    FinalDy = FinalY,

    lists:map(fun({Ox, Oy}) ->
        check_obstacle({Ox, Oy}, PathSet, FinalDx, FinalDy)
    end, Obstacles).

check_obstacle({Ox, Oy}, PathSet, FinalDx, FinalDy) ->
    if sets:is_element({Ox, Oy}, PathSet) ->
        true;
    true ->
        PathList = sets:to_list(PathSet),

        lists:any(fun({Px, Py}) ->
            DiffX = Ox - Px,
            DiffY = Oy - Py,

            if FinalDx == 0 andalso FinalDy == 0 ->
                false;
            FinalDx == 0 ->
                DiffX == 0 andalso
                (DiffY rem FinalDy == 0) andalso
                (DiffY div FinalDy >= 0);
            FinalDy == 0 ->
                DiffY == 0 andalso
                (DiffX rem FinalDx == 0) andalso
                (DiffX div FinalDx >= 0);
            true ->
                (DiffX rem FinalDx == 0) andalso
                (DiffY rem FinalDy == 0) andalso
                begin
                    Kx = DiffX div FinalDx,
                    Ky = DiffY div FinalDy,
                    Kx == Ky andalso Kx >= 0
                end
            end
        end, PathList)
    end.