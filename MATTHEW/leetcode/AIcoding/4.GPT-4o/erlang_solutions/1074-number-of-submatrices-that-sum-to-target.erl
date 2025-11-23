-module(solution).
-export([num_submatrix_sum_target/2]).

num_submatrix_sum_target(Matrix, Target) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Sums = lists:foldl(fun(Row, Acc) -> 
        RowSum = lists:foldl(fun(X, Acc2) -> 
            case Acc2 of 
                [] -> [X]; 
                [_ | _] -> [hd(Acc2) + X | tl(Acc2)]
            end 
        end, [], Row),
        [RowSum | Acc]
    end, [], Matrix),
    find_submatrices(Sums, Target, Rows, Cols).

find_submatrices(Sums, Target, Rows, Cols) ->
    lists:foldl(fun(TopRow, Acc) -> 
        lists:foldl(fun(BottomRow, Acc2) -> 
            SumMap = maps:new(),
            SumMap1 = maps:put(0, 1, SumMap),
            SumList = lists:map(fun(X) -> lists:nth(X, BottomRow) - lists:nth(X, TopRow) end, lists:seq(1, Cols)),
            {Count, _} = lists:foldl(fun(X, {CountAcc, Map}) ->
                Cumulative = hd(Map) + X,
                NewCount = maps:get(Cumulative - Target, Map, 0),
                UpdatedMap = maps:update(Cumulative, fun(Y) -> Y + 1 end, Map),
                {CountAcc + NewCount, UpdatedMap}
            end, {0, SumMap1}, SumList),
            Acc2 + Count
        end, Acc, lists:seq(0, Rows - 1))
    end, 0, lists:seq(0, Rows - 1)).