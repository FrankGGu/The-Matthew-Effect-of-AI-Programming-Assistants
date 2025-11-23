-spec surface_area(Grid :: [[integer()]]) -> integer().
surface_area(Grid) ->
    N = length(Grid),
    Surface = 0,
    lists:foldl(fun(I, AccI) ->
        lists:foldl(fun(J, AccJ) ->
            V = lists:nth(J + 1, lists:nth(I + 1, Grid)),
            if 
                V =:= 0 -> AccJ;
                true ->
                    AccJ + 4 * V + 2 - 
                    (if I > 0 -> min(V, lists:nth(J + 1, lists:nth(I, Grid))); true -> 0 end) -
                    (if I < N - 1 -> min(V, lists:nth(J + 1, lists:nth(I + 2, Grid))); true -> 0 end) -
                    (if J > 0 -> min(V, lists:nth(J, lists:nth(I + 1, Grid))); true -> 0 end) -
                    (if J < N - 1 -> min(V, lists:nth(J + 2, lists:nth(I + 1, Grid))); true -> 0 end)
            end
        end, AccI, lists:seq(0, N - 1))
    end, Surface, lists:seq(0, N - 1)).