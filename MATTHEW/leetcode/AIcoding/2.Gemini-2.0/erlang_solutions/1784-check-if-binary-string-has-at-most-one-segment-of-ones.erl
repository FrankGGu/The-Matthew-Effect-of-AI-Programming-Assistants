-module(solution).
-export([check_ones_segment/1]).

check_ones_segment(S) ->
  check_ones_segment_helper(S, false).

check_ones_segment_helper([], _SeenZero) ->
  true;
check_ones_segment_helper([$1 | T], SeenZero) ->
  check_ones_segment_helper(T, SeenZero);
check_ones_segment_helper([$0 | T], false) ->
  check_ones_segment_helper(T, true);
check_ones_segment_helper([$0 | _T], true) ->
  false.