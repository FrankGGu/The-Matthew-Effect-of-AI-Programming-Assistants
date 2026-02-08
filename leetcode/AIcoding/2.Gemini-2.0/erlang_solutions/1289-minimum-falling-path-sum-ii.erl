-module(min_falling_path_sum_ii).
-export([min_falling_path_sum/1]).

min_falling_path_sum(Matrix) ->
    Rows = length(Matrix),
    Cols = length(lists:nth(1, Matrix)),

    DP = lists:duplicate(Rows, lists:duplicate(Cols, 0)),

    % Initialize the first row of DP with the values from the first row of Matrix
    Row1 = lists:nth(1, Matrix),
    lists:nth(1, DP) ! Row1,

    % Iterate over the remaining rows of the matrix
    for(2, Rows, 1,
        fun(Row) ->
            PrevDP = lists:nth(Row - 1, DP),
            CurrentRow = lists:nth(Row, Matrix),

            for(1, Cols, 1,
                fun(Col) ->
                    MinSum = find_min_except(PrevDP, Col),
                    lists:nth(Row, DP) ! lists:nth(Row, DP) ++ [lists:nth(Col, CurrentRow) + MinSum]
                end
            )
        end
    ),

    % Find the minimum value in the last row of DP
    LastRowDP = lists:nth(Rows, DP),
    lists:min(LastRowDP).

find_min_except(List, Index) ->
    List1 = lists:sublist(List, 1, Index - 1),
    List2 = lists:sublist(List, Index + 1, length(List) - Index),

    All = List1 ++ List2,
    lists:min(All).