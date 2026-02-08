-module(maximum_number_of_ways_to_partition_an_array).
-export([max_ways_to_partition/1]).

max_ways_to_partition(Nums) ->
  max_ways_to_partition(Nums, 0, 0, 0, []).

max_ways_to_partition([], Total, Count, MaxCount, _) ->
  case Count > MaxCount of
    true -> Count;
    false -> MaxCount
  end;
max_ways_to_partition([H|T], Total, Count, MaxCount, PrefixSums) ->
  NewTotal = Total + H,
  NewPrefixSums = PrefixSums ++ [NewTotal],
  case NewTotal rem 2 == 0 of
    true ->
      Half = NewTotal div 2,
      NewCount = lists:foldl(
        fun(Sum, Acc) ->
          case Sum == Half of
            true -> Acc + 1;
            false -> Acc
          end
        end,
        0,
        NewPrefixSums
      ),
      NewMaxCount = max(MaxCount, NewCount),
      max_ways_to_partition(T, NewTotal, 0, NewMaxCount, []) ;
    false ->
      max_ways_to_partition(T, NewTotal, 0, MaxCount, [])
  end.

max(A, B) ->
  if A > B -> A;
  true -> B
  end.