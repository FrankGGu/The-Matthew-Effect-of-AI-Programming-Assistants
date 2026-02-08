-module(solution).
-export([num_distinct/2]).

num_distinct(S, T) ->
    N = string:length(S),
    M = string:length(T),
    Matrix = lists:duplicate(N + 1, lists:duplicate(M + 1, 0)),
    Matrix1 = lists:foldl(fun(_, Acc) -> lists:foldl(fun(_, Acc1) -> [0 | Acc1] end, [1], Acc) end, Matrix, lists:seq(0, N)),
    fill_matrix(Matrix1, S, T, N, M).

fill_matrix(Matrix, S, T, N, M) ->
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc1) ->
            case lists:nth(I, S) == lists:nth(J, T) of
                true -> lists:nth(I, Acc1) + lists:nth(J - 1, Acc1);
                false -> lists:nth(I, Acc1)
            end
        end, Acc, lists:seq(1, M))
    end, lists:tl(Matrix), lists:seq(1, N),
    lists:nth(N, Matrix).