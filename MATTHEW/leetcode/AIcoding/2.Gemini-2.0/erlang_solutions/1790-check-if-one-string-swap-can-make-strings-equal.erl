-module(solution).
-export([areAlmostEqual/2]).

areAlmostEqual(S1, S2) ->
  areAlmostEqual(string:to_list(S1), string:to_list(S2), 0, []).

areAlmostEqual([], [], Acc, _) when Acc =< 1 ->
  true;
areAlmostEqual([], [], Acc, _) ->
  false;
areAlmostEqual([H1|T1], [H2|T2], Acc, Diff) ->
  if
    H1 == H2 ->
      areAlmostEqual(T1, T2, Acc, Diff);
    true ->
      case Diff of
        [] ->
          areAlmostEqual(T1, T2, Acc + 1, [{H1, H2}]);
        [{A, B}] ->
          if
            H1 == B and H2 == A ->
              areAlmostEqual(T1, T2, Acc + 1, [{A, B}, {H1, H2}]);
            true ->
              false
          end
      end
  end.