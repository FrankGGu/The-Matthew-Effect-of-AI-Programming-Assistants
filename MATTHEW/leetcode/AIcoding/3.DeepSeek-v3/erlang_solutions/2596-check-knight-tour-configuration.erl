-spec check_valid_grid(Grid :: [[integer()]]) -> boolean().
check_valid_grid(Grid) ->
    N = length(Grid),
    Positions = lists:sort([{Val, I, J} || {Row, I} <- lists:zip(Grid, lists:seq(0, N-1)), 
                                          {Val, J} <- lists:zip(Row, lists:seq(0, N-1))]),
    case Positions of
        [] -> true;
        [{0, X0, Y0} | Rest] -> check_moves(Rest, X0, Y0, N);
        _ -> false
    end.

check_moves([], _, _, _) -> true;
check_moves([{Next, X, Y} | Rest], X0, Y0, N) ->
    DX = abs(X - X0),
    DY = abs(Y - Y0),
    if
        ((DX =:= 2 andalso DY =:= 1) orelse (DX =:= 1 andalso DY =:= 2)) andalso Next =:= Next ->
            check_moves(Rest, X, Y, N);
        true -> false
    end.