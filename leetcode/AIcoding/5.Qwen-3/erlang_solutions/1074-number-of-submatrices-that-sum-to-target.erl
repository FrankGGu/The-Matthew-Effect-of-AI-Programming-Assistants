-module(solution).
-export([num_submatrix_sum_k/2]).

num_submatrix_sum_k(Matrix, K) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Sum = 0,
    Count = 0,
    build_prefix_sums(Matrix, Rows, Cols, Sum, Count).

build_prefix_sums(_, _, _, _, Count) when Count >= 100000 -> Count;
build_prefix_sums(Matrix, Rows, Cols, Sum, Count) ->
    % Convert matrix to 2D list
    MatrixList = lists:map(fun(Row) -> Row end, Matrix),
    % Precompute prefix sums for each row
    RowPrefixSums = lists:map(
        fun(Row) ->
            lists:foldl(
                fun(X, Acc) ->
                    [lists:last(Acc) + X | Acc]
                end,
                [0],
                Row
            )
        end,
        MatrixList
    ),
    % For each pair of columns (left, right)
    build_col_pairs(RowPrefixSums, 0, Cols - 1, Rows, K, Count).

build_col_pairs(_, Left, Cols, _, _, Count) when Left >= Cols -> Count;
build_col_pairs(RowPrefixSums, Left, Right, Rows, K, Count) ->
    % Compute the sum of each row between left and right
    RowSums = lists:map(
        fun(Row) ->
            lists:nth(Right + 1, Row) - lists:nth(Left, Row)
        end,
        RowPrefixSums
    ),
    % Use a hash map to count the number of subarrays that sum to K
    Count1 = count_subarray_sum(RowSums, K),
    % Move to next right column
    build_col_pairs(RowPrefixSums, Left, Right + 1, Rows, K, Count + Count1).

count_subarray_sum(Sums, K) ->
    Map = #{0 => 1},
    CurrentSum = 0,
    Count = 0,
    count_subarray_sum(Sums, K, CurrentSum, Map, Count).

count_subarray_sum([], _, _, _, Count) -> Count;
count_subarray_sum([H | T], K, CurrentSum, Map, Count) ->
    NewSum = CurrentSum + H,
    PrevCount = maps:get(NewSum - K, Map, 0),
    NewCount = Count + PrevCount,
    NewMap = maps:update(NewSum, maps:get(NewSum, Map, 0) + 1, Map),
    count_subarray_sum(T, K, NewSum, NewMap, NewCount).