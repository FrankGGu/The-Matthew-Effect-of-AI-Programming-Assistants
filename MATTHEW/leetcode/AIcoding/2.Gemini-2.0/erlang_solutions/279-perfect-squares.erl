-module(perfect_squares).
-export([num_squares/1]).

num_squares(N) ->
  num_squares_helper(N, []).

num_squares_helper(0, Acc) ->
  length(Acc);
num_squares_helper(N, Acc) when N < 0 ->
  infinity;
num_squares_helper(N, Acc) ->
  Sqrt = floor(math:sqrt(N)),
  case Sqrt * Sqrt =:= N of
    true ->
      length(Acc) + 1;
    false ->
      Min = infinity,
      lists:foldl(
        fun(I, AccMin) ->
          NewN = N - I * I,
          Result = num_squares_helper(NewN, [I | Acc]),
          min(AccMin, Result)
        end,
        Min,
        lists:seq(1, Sqrt)
      )
  end.

infinity() -> 16#ffffffff.