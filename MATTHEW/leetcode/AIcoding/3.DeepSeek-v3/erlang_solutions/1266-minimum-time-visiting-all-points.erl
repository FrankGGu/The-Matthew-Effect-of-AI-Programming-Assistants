-spec min_time_to_visit_all_points(Points :: [[integer()]]) -> integer().
min_time_to_visit_all_points(Points) ->
    lists:foldl(fun([X1, Y1], {X0, Y0, Time}) ->
                    Dx = abs(X1 - X0),
                    Dy = abs(Y1 - Y0),
                    {X1, Y1, Time + max(Dx, Dy)}
                end, {hd(hd(Points)), hd(tl(hd(Points))), 0}, tl(Points)),
    element(3, {X, Y, Time}) when is_list(Points) -> Time.