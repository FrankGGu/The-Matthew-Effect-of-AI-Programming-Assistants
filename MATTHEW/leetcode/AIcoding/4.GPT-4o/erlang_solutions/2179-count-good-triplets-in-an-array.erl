-module(count_good_triplets).
-export([count_good_triplets/3]).

count_good_triplets(A, a, b) ->
    N = length(A),
    count_triplets(A, a, b, N, 0).

count_triplets(A, a, b, N, Count) ->
    lists:foldl(fun(X, Acc) ->
        lists:foldl(fun(Y, Acc2) ->
            lists:foldl(fun(Z, Acc3) ->
                if
                    (X < Y) andalso (Y < Z) andalso (abs(X - Y) <= a) andalso (abs(Y - Z) <= b) ->
                        Acc3 + 1;
                    true ->
                        Acc3
                end
            end, Acc2, lists:sublist(A, lists:indexof(A, Y) + 1, N - lists:indexof(A, Y) - 1))
        end, Acc, lists:sublist(A, lists:indexof(A, X) + 1, N - lists:indexof(A, X) - 1))
    end, Count, A).