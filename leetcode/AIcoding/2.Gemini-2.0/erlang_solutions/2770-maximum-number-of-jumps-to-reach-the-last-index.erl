-module(maximum_jumps).
-export([maxJumps/2]).

maxJumps(Arr, D) ->
  N = length(Arr),
  dp(Arr, D, lists:seq(1, N), array:new([{default, -1}])),
  array:get(N, array:freeze(dp(Arr, D, lists:seq(1, N), array:new([{default, -1}]))))).

dp(Arr, D, [], DP) ->
  DP;
dp(Arr, D, [I|Rest], DP) ->
  case array:get(I, DP) of
    -1 ->
      Value = Arr !! (I - 1),
      Jumps = find_jumps(Arr, D, I, DP),
      MaxValue = lists:foldl(fun(J, Acc) ->
                                  max(Acc, array:get(J, DP) + 1)
                              end, 1, Jumps),
      dp(Arr, D, Rest, array:set(I, MaxValue, DP));
    _ ->
      dp(Arr, D, Rest, DP)
  end.

find_jumps(Arr, D, I, DP) ->
  N = length(Arr),
  Value = Arr !! (I - 1),
  PossibleJumps = lists:filter(fun(J) -> abs(J - I) =< D end, lists:seq(1, N)),
  ValidJumps = lists:filter(fun(J) ->
                                ValueJ = Arr !! (J - 1),
                                if J > I ->
                                  ok = check_intermediate(Arr, I, J, Value),
                                  ValueJ > Value andalso ok == ok;
                                true ->
                                  ok = check_intermediate(Arr, J, I, Value),
                                  ValueJ > Value andalso ok == ok
                                end
                            end, PossibleJumps),
  ValidJumps.

check_intermediate(Arr, Start, End, Value) ->
  case lists:all(fun(Index) ->
                      Arr !! (Index - 1) =< Value
                  end, lists:seq(min(Start + 1, End - 1), max(Start + 1, End - 1))) of
    true -> ok;
    false -> false
  end.