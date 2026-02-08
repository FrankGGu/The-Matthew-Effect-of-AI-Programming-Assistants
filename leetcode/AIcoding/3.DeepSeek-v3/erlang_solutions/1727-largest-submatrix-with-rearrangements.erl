-spec largest_submatrix(Matrix :: [[integer()]]) -> integer().
largest_submatrix(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Hist = lists:foldl(fun(Row, Acc) ->
        lists:zipwith(fun(Val, H) -> if Val == 1 -> H + 1; true -> 0 end end, Row, Acc)
    end, lists:duplicate(Cols, 0), Matrix),
    lists:foldl(fun(Row, MaxArea) ->
        Sorted = lists:sort(fun(A, B) -> A >= B end, Row),
        NewMax = lists:foldl(fun({H, I}, CurrentMax) ->
            max(CurrentMax, H * (I + 1))
        end, 0, lists:zip(Sorted, lists:seq(0, Cols - 1))),
        max(MaxArea, NewMax)
    end, 0, [Hist]).