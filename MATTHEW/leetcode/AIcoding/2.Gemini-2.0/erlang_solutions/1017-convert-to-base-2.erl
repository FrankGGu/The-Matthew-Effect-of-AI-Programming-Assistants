-module(base_neg2).
-export([baseNeg2/1]).

baseNeg2(N) ->
  baseNeg2_helper(N, []).

baseNeg2_helper(0, Acc) ->
  case Acc of
    [] -> "0";
    _ -> lists:reverse(Acc)
  end;
baseNeg2_helper(N, Acc) ->
  Rem = N rem -2,
  case Rem of
    0 ->
      baseNeg2_helper(N div -2, ["0" | Acc]);
    1 ->
      baseNeg2_helper((N - 1) div -2, ["1" | Acc]);
    -1 ->
      baseNeg2_helper((N + 1) div -2, ["1" | Acc]);
    _ ->
      io:format("Error: Unexpected remainder ~w~n", [Rem]),
      []
  end.