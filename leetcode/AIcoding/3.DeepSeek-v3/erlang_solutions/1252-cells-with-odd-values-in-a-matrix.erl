-spec odd_cells(N :: integer(), M :: integer(), Indices :: [[integer()]]) -> integer().
odd_cells(N, M, Indices) ->
    Row = lists:duplicate(M, 0),
    Matrix = lists:duplicate(N, Row),
    UpdatedMatrix = lists:foldl(fun([Ri, Ci], Acc) ->
        RowToUpdate = lists:nth(Ri + 1, Acc),
        UpdatedRow = lists:map(fun({Index, Val}) -> 
            if Index =:= Ci -> {Index, Val + 1};
               true -> {Index, Val}
            end
        end, lists:zip(lists:seq(0, M - 1), RowToUpdate)),
        lists:sublist(Acc, Ri) ++ [lists:map(fun({_, V}) -> V end, UpdatedRow)] ++ lists:nthtail(Ri + 1, Acc)
    end, Matrix, Indices),
    CountOdd = fun(List) -> length([X || X <- List, X rem 2 =/= 0]) end,
    lists:sum(lists:map(CountOdd, UpdatedMatrix)).