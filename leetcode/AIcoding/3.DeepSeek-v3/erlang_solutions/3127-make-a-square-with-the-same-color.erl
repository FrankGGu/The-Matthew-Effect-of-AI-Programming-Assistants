-spec can_make_square(Grid :: [[char()]]) -> boolean().
can_make_square(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    case Rows < 2 orelse Cols < 2 of
        true -> false;
        false ->
            lists:any(fun({I, J}) ->
                Colors = [lists:nth(J, lists:nth(I, Grid)),
                          lists:nth(J+1, lists:nth(I, Grid)),
                          lists:nth(J, lists:nth(I+1, Grid)),
                          lists:nth(J+1, lists:nth(I+1, Grid))],
                (lists:member('B', Colors) andalso not lists:member('W', Colors)) orelse
                (lists:member('W', Colors) andalso not lists:member('B', Colors))
            end, [{I, J} || I <- lists:seq(1, Rows - 1), J <- lists:seq(1, Cols - 1)])
    end.