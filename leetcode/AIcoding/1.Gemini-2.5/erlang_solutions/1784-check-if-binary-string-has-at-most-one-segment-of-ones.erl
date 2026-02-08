-module(solution).
-export([check_ones_segment/1]).

-spec check_ones_segment(S :: unicode:unicode_binary()) -> boolean().
check_ones_segment(S) ->
    check_ones_segment_list(binary_to_list(S)).

check_ones_segment_list(L) ->
    check_ones_segment_loop(L, 0).

check_ones_segment_loop([], _State) ->
    true;

check_ones_segment_loop([$0 | T], 0) ->
    check_ones_segment_loop(T, 0);

check_ones_segment_loop([$1 | T], 0) ->
    check_ones_segment_loop(T, 1);

check_ones_segment_loop([$1 | T], 1) ->
    check_ones_segment_loop(T, 1);

check_ones_segment_loop([$0 | T], 1) ->
    check_ones_segment_loop(T, 2);

check_ones_segment_loop([$0 | T], 2) ->
    check_ones_segment_loop(T, 2);

check_ones_segment_loop([$1 | T], 2) ->
    false.