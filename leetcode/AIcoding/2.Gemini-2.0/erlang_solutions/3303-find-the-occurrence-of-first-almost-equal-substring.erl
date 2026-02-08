-module(solution).
-export([find_first_occurrence/2]).

find_first_occurrence(S, T) ->
  find_first_occurrence(S, T, 0).

find_first_occurrence(S, T, Start) ->
  LenS = length(S),
  LenT = length(T),
  Diff = abs(LenS - LenT),

  if Diff > 3 ->
    -1
  else
    find_substring(S, T, 0)
  end.

find_substring(S, T, Start) ->
  LenS = length(S),
  LenT = length(T),
  if Start + LenT > LenS ->
    -1
  else
    Sub = lists:sublist(S, Start + 1, LenT),
    if almost_equal(Sub, T) ->
      Start
    else
      find_substring(S, T, Start + 1)
    end
  end.

almost_equal(S, T) ->
  almost_equal(S, T, 0).

almost_equal([], [], Diff) ->
  Diff =< 3;
almost_equal([H1|R1], [H2|R2], Diff) ->
  if H1 =/= H2 ->
    if Diff < 3 ->
      almost_equal(R1, R2, Diff + 1)
    else
      false
    end
  else
    almost_equal(R1, R2, Diff)
  end;
almost_equal(_, _, _) ->
  false.