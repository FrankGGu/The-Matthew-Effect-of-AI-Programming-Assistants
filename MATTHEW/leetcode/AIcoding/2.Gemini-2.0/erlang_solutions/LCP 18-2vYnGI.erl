-module(breakfast_combo).
-export([num_of_ways/2]).

num_of_ways(S, T) ->
  food_counts(S, T).

food_counts(S, T) ->
  lists:sort(S),
  lists:foldl(
    fun(x, Acc) ->
      Count = count_pairs(x, S, T),
      (Acc + Count) rem 1000000007
    end,
    0,
    S
  ).

count_pairs(X, S, T) ->
  Count = lists:foldl(
    fun(Y, Acc) ->
      if X + Y =< T ->
        Acc + 1
      else
        Acc
      end
    end,
    0,
    S
  ),

  FilteredS = lists:filter(fun(E) -> E < X end, S),
  SameCount = lists:foldl(
      fun(E, Acc) ->
        if (E == X) ->
          Acc + 1;
        true ->
          Acc
      end,
      0,
      S
  ),

  ValidCount = lists:filter(fun(Y) -> X + Y =< T end, S),

  LenValid = length(ValidCount),
  LenS = length(S),

  if (X * 2 > T) ->
    0;

  (LenValid - (LenS - length(lists:usort(S)))) rem 1000000007.