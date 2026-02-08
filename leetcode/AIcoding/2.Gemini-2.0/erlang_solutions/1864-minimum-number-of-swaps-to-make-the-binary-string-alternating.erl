-module(min_swaps).
-export([min_swaps/1]).

min_swaps(S) ->
  Len = length(S),
  Zeros = lists:filter(fun(C) -> C =:= $0 end, S),
  Ones = lists:filter(fun(C) -> C =:= $1 end, S),
  ZerosLen = length(Zeros),
  OnesLen = length(Ones),

  case abs(ZerosLen - OnesLen) > 1 of
    true ->
      -1;
    false ->
      Swaps01 = swaps_needed(S, $0),
      Swaps10 = swaps_needed(S, $1),
      case ZerosLen > OnesLen of
        true ->
          Swaps01;
        false ->
          case OnesLen > ZerosLen of
            true ->
              Swaps10;
            false ->
              min(Swaps01, Swaps10)
          end
      end
  end.

swaps_needed(S, Start) ->
  swaps_needed(S, Start, 0, 0).

swaps_needed([], _, Swaps, _) ->
  Swaps;
swaps_needed([H|T], Expected, Swaps, Index) ->
  case H =/= Expected of
    true ->
      swaps_needed(T, opposite(Expected), Swaps + 1, Index + 1);
    false ->
      swaps_needed(T, opposite(Expected), Swaps, Index + 1)
  end.

opposite($0) ->
  $1;
opposite($1) ->
  $0.