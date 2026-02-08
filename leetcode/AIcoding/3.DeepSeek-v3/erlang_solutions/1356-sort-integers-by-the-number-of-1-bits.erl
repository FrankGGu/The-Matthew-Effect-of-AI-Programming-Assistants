-module(solution).
-export([sort_by_bits/1]).

sort_by_bits(Arr) ->
    lists:sort(fun(A, B) ->
                  case count_bits(A) =:= count_bits(B) of
                      true -> A =< B;
                      false -> count_bits(A) =< count_bits(B)
                  end
              end, Arr).

count_bits(N) ->
    count_bits(N, 0).

count_bits(0, Acc) -> Acc;
count_bits(N, Acc) ->
    count_bits(N bsr 1, Acc + (N band 1)).