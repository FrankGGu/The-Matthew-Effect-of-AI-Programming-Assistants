-module(solution).
-export([sort_by_bits/1]).

sort_by_bits(Arr) ->
    lists:sort(fun(A, B) ->
                       BitsA = count_bits(A),
                       BitsB = count_bits(B),
                       case BitsA =:= BitsB of
                           true -> A < B;
                           false -> BitsA < BitsB
                       end
               end, Arr).

count_bits(N) ->
    count_bits(N, 0).

count_bits(0, Acc) ->
    Acc;
count_bits(N, Acc) ->
    count_bits(N band (N - 1), Acc + 1).