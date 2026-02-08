-module(find_partition).
-export([find_value_of_partition/1]).

find_value_of_partition(Nums) ->
  SortedNums = lists:sort(Nums),
  MinDiff = lists:foldl(fun(N, Acc) ->
                                case Acc of
                                  undefined ->
                                    {N, undefined, infinity};
                                  {Prev, _, Min} ->
                                    Diff = abs(N - Prev),
                                    {N, Diff, min(Min, Diff)}
                                end
                        end, undefined, SortedNums),
  case MinDiff of
    {_, _, Min} ->
      Min
  end.