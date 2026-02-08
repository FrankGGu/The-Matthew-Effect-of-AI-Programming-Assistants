-module(num_matrix).
-export([new/1, sum_region/3]).

-record(matrix, {data = []}).

new(Matrix) ->
    #matrix{data = Matrix}.

sum_region(#matrix{data = Data}, row1, col1, row2, col2) ->
    Sum = lists:foldl(fun(Row, Acc) ->
        Acc + lists:sum(lists:sublist(Row, col1 + 1, col2 - col1 + 1))
    end, 0, lists:sublist(Data, row1 + 1, row2 - row1 + 1)),
    Sum.