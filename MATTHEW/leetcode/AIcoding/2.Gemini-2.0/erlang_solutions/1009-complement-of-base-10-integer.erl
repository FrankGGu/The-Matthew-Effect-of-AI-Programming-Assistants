-module(complement_of_base_10).
-export([bitwise_complement/1]).

bitwise_complement(N) ->
  if N =:= 0 ->
    1;
  true ->
    X = log(N)/log(2),
    Mask = trunc(math:pow(2, trunc(X) + 1)) - 1,
    N bxor Mask
  end.