-module(shortest_matching_substring).
-export([solve/2]).

solve(S, T) ->
  solve(S, T, 0, length(S) + 1).

solve(S, T, MinLen, BestLen) ->
  LenS = length(S),
  LenT = length(T),

  case LenT > LenS of
    true ->
      BestLen;
    false ->
      solve_helper(S, T, 0, MinLen, BestLen, LenS, LenT)
  end.

solve_helper(S, T, Start, MinLen, BestLen, LenS, LenT) ->
  case Start + LenT > LenS of
    true ->
      BestLen;
    false ->
      Sub = string:substr(S, Start + 1, LenT),
      case Sub == T of
        true ->
          case LenT < BestLen of
            true ->
              solve_helper(S, T, Start + 1, LenT, LenT, LenS, LenT);
            false ->
              solve_helper(S, T, Start + 1, MinLen, BestLen, LenS, LenT)
          end;
        false ->
          solve_helper(S, T, Start + 1, MinLen, BestLen, LenS, LenT)
      end
  end.