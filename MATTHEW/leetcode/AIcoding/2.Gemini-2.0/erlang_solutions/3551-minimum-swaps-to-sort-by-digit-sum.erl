-module(minimum_swaps).
-export([minimum_swaps/1]).

minimum_swaps(Nums) ->
  Len = length(Nums),
  IndexedNums = lists:zip(lists:seq(1, Len), Nums),
  SortedIndexedNums = lists:keysort(2, IndexedNums, fun(X) -> digit_sum(X) end),

  Visited = orddict:new(),
  Swaps = minimum_swaps_helper(SortedIndexedNums, 0, Visited).

minimum_swaps_helper([], Swaps, _) ->
    Swaps;
minimum_swaps_helper([H|T], Swaps, Visited) ->
  {Index, _} = H,
  case orddict:is_key(Index, Visited) of
    true ->
      minimum_swaps_helper(T, Swaps, Visited);
    false ->
      CycleSize = cycle_size(H, T, Visited),
      NewSwaps = Swaps + CycleSize - 1,
      minimum_swaps_helper(T, NewSwaps, Visited)
  end.

cycle_size({Index, _}, T, Visited) ->
  cycle_size_helper({Index, _}, T, orddict:store(Index, true, Visited), 1).

cycle_size_helper({Index, _}, T, Visited, Count) ->
  case lists:keyfind(Index, 1, T) of
    false ->
      Count;
    {ExpectedIndex, _} ->
      case orddict:is_key(ExpectedIndex, Visited) of
        true ->
          Count;
        false ->
          cycle_size_helper({ExpectedIndex, _}, T, orddict:store(ExpectedIndex, true, Visited), Count + 1)
      end
  end.

digit_sum(Num) ->
  digit_sum_helper(Num, 0).

digit_sum_helper(0, Sum) ->
  Sum;
digit_sum_helper(Num, Sum) ->
  Digit = Num rem 10,
  Rest = Num div 10,
  digit_sum_helper(Rest, Sum + Digit).

digit_sum({_, Num}) ->
  digit_sum(Num).