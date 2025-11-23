-module(minimum_swaps).
-export([min_swaps/1]).

min_swaps(S) ->
  min_swaps_helper(S, 0, 0).

min_swaps_helper([], Open, Swaps) ->
  Swaps + (Open + 1) div 2;
min_swaps_helper([C | Rest], Open, Swaps) ->
  case C of
    '[' ->
      min_swaps_helper(Rest, Open + 1, Swaps);
    ']' ->
      if Open > 0 then
        min_swaps_helper(Rest, Open - 1, Swaps)
      else
        min_swaps_helper(Rest, 0, Swaps + 1)
      end
  end.