-spec largest_triangle_area(Points :: [[integer()]]) -> float().
largest_triangle_area(Points) ->
    MaxArea = 0.0,
    N = length(Points),
    lists:foldl(fun(I, Acc1) ->
        lists:foldl(fun(J, Acc2) ->
            lists:foldl(fun(K, Acc3) ->
                P1 = lists:nth(I, Points),
                P2 = lists:nth(J, Points),
                P3 = lists:nth(K, Points),
                X1 = lists:nth(1, P1), Y1 = lists:nth(2, P1),
                X2 = lists:nth(1, P2), Y2 = lists:nth(2, P2),
                X3 = lists:nth(1, P3), Y3 = lists:nth(2, P3),
                Area = abs((X1*(Y2 - Y3) + X2*(Y3 - Y1) + X3*(Y1 - Y2)) / 2,
                max(Acc3, Area)
            end, Acc2, lists:seq(J + 1, N))
        end, Acc1, lists:seq(I + 1, N - 1))
    end, MaxArea, lists:seq(1, N - 2)).