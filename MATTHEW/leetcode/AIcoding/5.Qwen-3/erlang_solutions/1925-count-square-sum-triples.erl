-module(count_square_sum_triples).
-export([num_squares/1]).

num_squares(N) ->
    Count = 0,
    lists:foldl(fun(A, Acc) ->
        lists:foldl(fun(B, Acc2) ->
            C2 = A*A + B*B,
            if
                C2 < N*N ->
                    C = math:sqrt(C2),
                    if
                        is_integer(C) ->
                            Acc2 + 1;
                        true ->
                            Acc2
                    end;
                true ->
                    Acc2
            end
        end, Acc, lists:seq(1, N-1))
    end, Count, lists:seq(1, N-1)).