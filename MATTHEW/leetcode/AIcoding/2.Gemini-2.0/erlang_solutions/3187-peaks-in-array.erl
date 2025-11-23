-module(peaks_in_array).
-export([solve/1]).

solve(A) ->
  solve(A, 0, length(A) - 1).

solve(A, Low, High) ->
  if Low > High ->
    -1;
  true ->
    Mid = Low + (High - Low) div 2,
    case peak(A, Mid) of
      true ->
        Mid;
      false ->
        if Mid > Low andalso lists:nth(Mid - 1, A) > lists:nth(Mid, A) ->
          solve(A, Low, Mid - 1);
        true ->
          solve(A, Mid + 1, High)
        end
    end
  end.

peak(A, Index) ->
  Length = length(A),
  case Index of
    0 ->
      Index + 1 < Length andalso lists:nth(Index + 1, A) < lists:nth(Index, A);
    Length - 1 ->
      Index - 1 >= 0 andalso lists:nth(Index - 1, A) < lists:nth(Index, A);
    _ ->
      Index - 1 >= 0 andalso Index + 1 < Length andalso
        lists:nth(Index - 1, A) < lists:nth(Index, A) andalso
        lists:nth(Index + 1, A) < lists:nth(Index, A)
  end.