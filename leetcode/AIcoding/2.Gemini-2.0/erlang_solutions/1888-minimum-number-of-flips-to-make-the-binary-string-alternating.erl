-module(min_flips).
-export([minFlips/1]).

minFlips(S) ->
  Len = length(S),
  S1 = string:to_list(S),
  F1 = fun(Acc, I) ->
    C = lists:nth(I + 1, S1);
    Expected = case I rem 2 of
      0 -> $0;
      1 -> $1
    end,
    if C =/= Expected then
      Acc + 1
    else
      Acc
    end
  end,
  F2 = fun(Acc, I) ->
    C = lists:nth(I + 1, S1);
    Expected = case I rem 2 of
      0 -> $1;
      1 -> $0
    end,
    if C =/= Expected then
      Acc + 1
    else
      Acc
    end
  end,
  Flips1 = lists:foldl(F1, 0, lists:seq(0, Len - 1)),
  Flips2 = lists:foldl(F2, 0, lists:seq(0, Len - 1)),
  min(Flips1, Flips2).