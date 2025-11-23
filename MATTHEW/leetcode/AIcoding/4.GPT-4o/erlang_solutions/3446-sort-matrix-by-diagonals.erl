-module(solution).
-export([diagonal_sort/1]).

diagonal_sort(Matrix) ->
    Diags = get_diagonals(Matrix),
    SortedDiags = lists:map(fun(List) -> lists:sort(List) end, Diags),
    fill_matrix(Matrix, SortedDiags).

get_diagonals(Matrix) ->
    lists:foldl(fun({Row, Index}, Acc) ->
        lists:foldl(fun({Val, Col}, Acc2) ->
            DiagIndex = Row - Col,
            case lists:keyfind(DiagIndex, 1, Acc2) of
                false -> [{DiagIndex, [Val]} | Acc2];
                {DiagIndex, List} -> [{DiagIndex, [Val | List]} | lists:keydelete(DiagIndex, 1, Acc2)]
            end
        end, Acc, lists:zip(Matrix, lists:seq(0, length(Matrix) - 1)))
    end, [], lists:zip(Matrix, lists:seq(0, length(Matrix) - 1))).

fill_matrix(Matrix, SortedDiags) ->
    lists:map(fun(Row, RowIdx) ->
        lists:map(fun(Col, ColIdx) ->
            DiagIndex = RowIdx - ColIdx,
            case lists:keyfind(DiagIndex, 1, SortedDiags) of
                {_, [H | T]} -> {H, T};
                _ -> {0, []}
            end
        end, Row)
    end, Matrix).