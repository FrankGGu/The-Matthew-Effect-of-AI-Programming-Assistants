-module(minimum_swaps).
-export([minSwaps/1]).

minSwaps(Grid) ->
  N = length(Grid),
  Rightmost = lists:map(fun(Row) -> findRightmostZero(Row) end, Grid),
  Swaps = solve(Rightmost, N, 0, 0),
  Swaps.

findRightmostZero(Row) ->
  findRightmostZero(Row, length(Row) - 1).

findRightmostZero(Row, Index) ->
  case Index < 0 of
    true -> -1;
    false ->
      case lists:nth(Index + 1, Row) of
        0 -> Index;
        _ -> findRightmostZero(Row, Index - 1)
      end
  end.

solve([], _, Acc, _) -> Acc;
solve(Rightmost, N, Acc, I) ->
  Required = N - I - 1,
  FoundIndex = findIndex(Rightmost, Required, I),
  case FoundIndex =:= -1 of
    true -> -1;
    false ->
      NewRightmost = moveElement(Rightmost, FoundIndex, I),
      solve(NewRightmost, N, Acc + (FoundIndex - I), I + 1)
  end.

findIndex(Rightmost, Required, Start) ->
  findIndex(Rightmost, Required, Start, length(Rightmost) - 1).

findIndex(Rightmost, Required, Start, End) ->
  case Start > End of
    true -> -1;
    false ->
      case lists:nth(Start + 1, Rightmost) =< Required of
        true -> Start;
        false -> findIndex(Rightmost, Required, Start + 1, End)
      end
  end.

moveElement(List, From, To) ->
  {Left, [_ | Right]} = lists:split(From, List),
  Element = lists:nth(From + 1, List),
  lists:insert(To + 1, Left ++ Right, Element).