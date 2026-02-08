-module(subsequence_with_minimum_score).
-export([minimum_score/2]).

minimum_score(S, T) ->
  N = length(S),
  M = length(T),
  Left = lists:duplicate(M + 1, 0),
  Right = lists:duplicate(M + 1, N),
  Left[1] = -1,
  Right[M + 1] = N,

  Prefix =
    lists:foldl(
      fun(I, Acc) ->
        if Acc =:= M then
          Acc
        else
          if lists:nth(I + 1, S) =:= lists:nth(Acc + 2, T) then
            Left[Acc + 2] = I,
            Acc + 1
          else
            Acc
          end
        end
      end,
      -1,
      lists:seq(0, N - 1)
    ),

  Suffix =
    lists:foldl(
      fun(I, Acc) ->
        if Acc =:= -1 then
          Acc
        else
          if lists:nth(I + 1, S) =:= lists:nth(Acc + 1, T) then
            Right[Acc + 1] = I,
            Acc - 1
          else
            Acc
          end
        end,
      N,
      lists:seq(N - 1, 0, -1)
    ),

  lists:foldl(
    fun(I, MinScore) ->
      LeftI = Left[I],
      RightI = Right[I],
      if LeftI < RightI then
        MinScore
      else
        min(MinScore, RightI - LeftI - 1)
      end
    end,
    N,
    lists:seq(1, M + 1)
  ).