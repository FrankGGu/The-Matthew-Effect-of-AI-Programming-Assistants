-spec k_weakest_rows(Mat :: [[integer()]], K :: integer()) -> [integer()].
k_weakest_rows(Mat, K) ->
    Rows = lists:zip(lists:seq(0, length(Mat) - 1), Mat),
    Sums = lists:map(fun({Index, Row}) -> {Index, lists:sum(Row)} end, Rows),
    Sorted = lists:sort(fun({_, Sum1}, {_, Sum2}) -> 
                            if Sum1 =:= Sum2 -> false; true -> Sum1 =< Sum2 end
                        end, Sums),
    Indices = lists:map(fun({Index, _}) -> Index end, Sorted),
    lists:sublist(Indices, K).