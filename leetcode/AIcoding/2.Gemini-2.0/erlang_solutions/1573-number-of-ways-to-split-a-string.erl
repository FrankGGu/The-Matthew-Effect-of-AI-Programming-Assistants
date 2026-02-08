-module(number_of_ways_to_split_string).
-export([num_ways/1]).

num_ways(S) ->
  case count_ones(S) of
    0 ->
      N = length(S);
      (factorial(N - 1, 1) div (factorial(2, 1) * factorial(N - 3, 1))) rem 1000000007;
    Ones when Ones rem 3 /= 0 ->
      0;
    Ones ->
      TargetOnes = Ones div 3;
      {First, Second} = count_ways(S, TargetOnes);
      (First * Second) rem 1000000007
  end.

count_ones(S) ->
  count_ones(S, 0).

count_ones([], Acc) ->
  Acc;
count_ones([H | T], Acc) ->
  case H of
    $1 ->
      count_ones(T, Acc + 1);
    _ ->
      count_ones(T, Acc)
  end.

count_ways(S, TargetOnes) ->
  count_ways(S, TargetOnes, 0, 0, 0).

count_ways([], _, First, Second, _) ->
  {First, Second};
count_ways([H | T], TargetOnes, First, Second, Count) ->
  NewCount = case H of
    $1 ->
      Count + 1;
    _ ->
      Count
  end,
  case NewCount of
    TargetOnes when First == 0 ->
      count_ways(T, TargetOnes, 1, Second, NewCount);
    TargetOnes * 2 when Second == 0 ->
      count_ways(T, TargetOnes, First, 1, NewCount);
    TargetOnes when First > 0 ->
      count_ways(T, TargetOnes, First + 1, Second, NewCount);
    TargetOnes * 2 when Second > 0 ->
      count_ways(T, TargetOnes, First, Second + 1, NewCount);
    _ ->
      count_ways(T, TargetOnes, First, Second, NewCount)
  end.

factorial(0, Acc) ->
  Acc;
factorial(1, Acc) ->
  Acc;
factorial(N, Acc) ->
  factorial(N - 1, (N * Acc) rem 1000000007).