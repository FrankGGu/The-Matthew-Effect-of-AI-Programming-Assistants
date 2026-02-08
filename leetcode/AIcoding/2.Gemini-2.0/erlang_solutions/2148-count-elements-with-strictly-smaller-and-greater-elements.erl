-module(solution).
-export([countElements/1]).

countElements(Nums) ->
  case Nums of
    [] -> 0;
    [Single] -> 0;
    _ ->
      SortedNums = lists:sort(Nums),
      Smallest = lists:nth(1, SortedNums),
      Largest = lists:nth(length(SortedNums), SortedNums),
      countElementsHelper(SortedNums, Smallest, Largest, 0)
  end.

countElementsHelper([], _Smallest, _Largest, Count) ->
  Count;
countElementsHelper([H|T], Smallest, Largest, Count) ->
  case (H > Smallest) and (H < Largest) of
    true ->
      countElementsHelper(T, Smallest, Largest, Count + 1);
    false ->
      countElementsHelper(T, Smallest, Largest, Count)
  end.