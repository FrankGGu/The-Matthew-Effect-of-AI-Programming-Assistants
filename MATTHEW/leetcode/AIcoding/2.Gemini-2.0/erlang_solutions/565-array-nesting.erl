-module(array_nesting).
-export([array_nesting/1]).

array_spec([], Acc) -> Acc;
array_spec([H|T], Acc) ->
  array_spec(T, Acc ++ [H]).

array_nesting(Nums) ->
  array_nesting(Nums, 0, []).

array_nesting([], Max, _Visited) -> Max;
array_nesting(Nums, Max, Visited) ->
  case Nums of
    [] -> Max;
    [H|T] ->
      case lists:member(H, Visited) of
        true -> array_nesting(T, Max, Visited);
        false ->
          Len = cycle_len(H, Nums, [], H),
          array_nesting(T, max(Max, Len), Visited ++ [H])
      end
  end.

cycle_len(Start, Nums, Visited, OriginalStart) ->
  Index = lists:index(Start, Nums),
  Next = lists:nth(Index, Nums),
  case lists:member(Next, Visited) of
    true -> length(Visited);
    false ->
      case Next == OriginalStart of
        true -> length(Visited) + 1;
        false -> cycle_len(Next, Nums, Visited ++ [Next], OriginalStart)
      end
  end.