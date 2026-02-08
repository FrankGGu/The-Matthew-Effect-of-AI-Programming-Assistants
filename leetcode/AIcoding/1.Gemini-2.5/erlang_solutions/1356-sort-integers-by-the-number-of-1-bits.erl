-module(solution).
-export([sort_by_bits/1]).

sort_by_bits(Arr) ->
    lists:sort(fun(A, B) ->
                       BitsA = count_set_bits(A),
                       BitsB = count_set_bits(B),
                       if
                           BitsA < BitsB -> true;
                           BitsA > BitsB -> false;
                           true -> A < B
                       end
               end, Arr).

count_set_bits(N) -> count_set_bits(N, 0).
count_set_bits(0, Acc) -> Acc;
count_set_bits(N, Acc) -> count_set_bits(N bsr 1, Acc + (N band 1)).