-module(frequencies_shortest_supersequences).
-export([solve/2]).

solve(big, small) ->
  solve(big, small, [], 0, length(big) + 1, 0, 1).

solve([], _, Accumulator, _, _, _, Count) ->
  {lists:reverse(Accumulator), Count};
solve(_, [], Accumulator, _, _, _, Count) ->
  {lists:reverse(Accumulator), Count};
solve(Big, Small, Accumulator, StartIndex, MinLength, MinStartIndex, Count) ->
  case find_shortest_supersequence(Big, Small) of
    none ->
      {lists:reverse(Accumulator), Count};
    {Start, Length} ->
      case Length < MinLength of
        true ->
          solve(Big, Small, [Start | Accumulator], Start, Length, Start, 1);
        false ->
          case Length == MinLength of
            true ->
              solve(Big, Small, [Start | Accumulator], Start, MinLength, MinStartIndex,
                    case Start =:= MinStartIndex of
                      true -> Count + 1;
                      false -> Count
                    end);
            false ->
              {lists:reverse(Accumulator), Count}
          end
      end
  end.

find_shortest_supersequence(Big, Small) ->
  find_shortest_supersequence(Big, Small, 1, 1, 0, length(Big) + 1, 0).

find_shortest_supersequence([], _, _, _, MinStart, MinLength, _) ->
  case MinLength =< length(Big) of
    true -> {MinStart, MinLength};
    false -> none
  end;
find_shortest_supersequence(_, [], Start, _, MinStart, MinLength, CurrentLength) ->
  Length = CurrentLength,
  case Length < MinLength of
    true ->
      {Start, Length};
    false ->
      case Length =:= MinLength of
        true ->
          {MinStart, MinLength};
        false ->
          none
      end
  end.

find_shortest_supersequence([BigHead | BigTail], [SmallHead | SmallTail], Start, CurrentIndex, MinStart, MinLength, CurrentLength) ->
  case BigHead =:= SmallHead of
    true ->
      find_shortest_supersequence(BigTail, SmallTail, Start, CurrentIndex + 1, MinStart, MinLength, CurrentLength + 1);
    false ->
      find_shortest_supersequence(BigTail, [SmallHead | SmallTail], Start, CurrentIndex + 1, MinStart, MinLength, CurrentLength + 1)
  end;
find_shortest_supersequence([BigHead | BigTail], Small, Start, CurrentIndex, MinStart, MinLength, CurrentLength) ->
  case Small of
    [] ->
      Length = CurrentLength,
      case Length < MinLength of
        true ->
          {Start, Length};
        false ->
          case Length =:= MinLength of
            true ->
              {MinStart, MinLength};
            false ->
              none
          end
      end;
    _ ->
      find_shortest_supersequence(BigTail, Small, Start, CurrentIndex + 1, MinStart, MinLength, CurrentLength + 1)
  end.