-spec min_area(Grid :: [[char()]], K :: integer()) -> integer().
min_area(Grid, K) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Ones = lists:append([ [{I, J} || {J, V} <- lists:zip(lists:seq(0, Cols - 1), Row), V =:= $1] || {I, Row} <- lists:zip(lists:seq(0, Rows - 1), Grid)]),
    case Ones of
        [] -> 0;
        _ ->
            {MinX, MaxX} = {lists:min([X || {X, _} <- Ones]), lists:max([X || {X, _} <- Ones])},
            {MinY, MaxY} = {lists:min([Y || {_, Y} <- Ones]), lists:max([Y || {_, Y} <- Ones])},
            (MaxX - MinX + 1) * (MaxY - MinY + 1)
    end.