-module(solution).
-export([k_weakest_rows/2]).

k_weakest_rows(Matrix, K) ->
    Rows = lists:zip(lists:seq(1, length(Matrix)), Matrix),
    Sorted = lists:sort(fun({I1, R1}, {I2, R2}) ->
                            Count1 = count_ones(R1),
                            Count2 = count_ones(R2),
                            if
                                Count1 < Count2 -> true;
                                Count1 == Count2 -> I1 < I2;
                                true -> false
                            end
                        end, Rows),
    [Row || {Row, _} <- lists:sublist(Sorted, K)].

count_ones([]) -> 0;
count_ones([1 | T]) -> 1 + count_ones(T);
count_ones([0 | T]) -> count_ones(T).