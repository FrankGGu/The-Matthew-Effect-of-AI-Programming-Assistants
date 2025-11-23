-spec max_sum_submatrix(Matrix :: [[integer()]], K :: integer()) -> integer().
max_sum_submatrix(Matrix, K) ->
    case Matrix of
        [] -> 0;
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            MaxSum = -infinity,
            lists:foldl(fun(C1, AccMax) ->
                RowSums = lists:duplicate(Rows, 0),
                lists:foldl(fun(C2, {RowSums1, CurrentMax}) ->
                    NewRowSums = lists:zipwith(fun(Row, Sum) ->
                        lists:nth(C2 + 1, Row) + Sum
                    end, Matrix, RowSums1),
                    {NewRowSums, max(CurrentMax, max_subarray_no_larger_than_k(NewRowSums, K))}
                end, {RowSums, AccMax}, lists:seq(C1, Cols - 1))
            end, MaxSum, lists:seq(0, Cols - 1))
    end.

max_subarray_no_larger_than_k(Nums, K) ->
    Sorted = gb_sets:new(),
    gb_sets:insert(0, Sorted),
    Prefix = 0,
    MaxSum = -infinity,
    lists:foldl(fun(Num, {Prefix1, Sorted1, CurrentMax}) ->
        Prefix2 = Prefix1 + Num,
        case gb_sets:is_empty(Sorted1) of
            true -> 
                {Prefix2, gb_sets:insert(Prefix2, Sorted1), CurrentMax};
            false ->
                case gb_sets:iterator_from(Prefix2 - K, Sorted1) of
                    none -> 
                        {Prefix2, gb_sets:insert(Prefix2, Sorted1), CurrentMax};
                    Iter ->
                        {Val, _} = gb_sets:next(Iter),
                        Candidate = Prefix2 - Val,
                        NewMax = max(CurrentMax, Candidate),
                        {Prefix2, gb_sets:insert(Prefix2, Sorted1), NewMax}
                end
        end
    end, {Prefix, Sorted, MaxSum}, Nums),
    MaxSum.