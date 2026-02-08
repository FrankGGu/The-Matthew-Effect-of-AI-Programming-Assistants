-module(sticks).
-export([num_ways/2]).

num_ways(N, K) ->
  num_ways(N, K, array:new(N+1, [{default, array:new(N+1, [{default, -1}])}])).

num_ways(N, K, Memo) when K =< 0 orelse K > N ->
  0;
num_ways(N, 1, Memo) ->
  factorial(N-1);
num_ways(N, K, Memo) ->
  case array:get({N, K}, Memo) of
    -1 ->
      Val = (num_ways(N-1, K-1, Memo) + (N-1) * num_ways(N-1, K, Memo));
      Memo2 = array:set({N, K}, Val, Memo);
      Val;
    Val ->
      Val
  end.

factorial(N) ->
    factorial(N, 1).

factorial(0, Acc) ->
    Acc;
factorial(N, Acc) ->
    factorial(N-1, N*Acc).

array:new(Size, Opts) ->
  array:new([fixed_size, size=Size] ++ Opts).