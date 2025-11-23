-module(string_transformation).
-export([solve/1]).

solve([Start, End, Bank]) ->
  solve(Start, End, Bank, [], 0).

solve(Start, End, Bank, Visited, Count) ->
  if Start == End ->
    Count;
  true ->
    NextWords = [Word || Word <- Bank,
                      not lists:member(Word, Visited),
                      difference(Start, Word) == 1],
    case NextWords of
      [] ->
        -1;
      _ ->
        MinCounts = [solve(Word, End, Bank, [Start | Visited], Count + 1) || Word <- NextWords],
        ValidCounts = [C || C <- MinCounts, C >= 0],
        case ValidCounts of
          [] ->
            -1;
          _ ->
            lists:min(ValidCounts)
        end
    end
  end.

difference(Word1, Word2) ->
  difference(Word1, Word2, 0).

difference([], [], Acc) ->
  Acc;
difference([H1 | T1], [H2 | T2], Acc) ->
  if H1 == H2 ->
    difference(T1, T2, Acc);
  true ->
    difference(T1, T2, Acc + 1)
  end.