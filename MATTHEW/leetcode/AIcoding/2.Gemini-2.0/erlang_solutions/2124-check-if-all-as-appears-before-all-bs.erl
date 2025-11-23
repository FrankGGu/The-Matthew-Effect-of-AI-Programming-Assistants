-module(solution).
-export([check_if_all_a_appears_before_b/1]).

check_if_all_a_appears_before_b(S) ->
  check_if_all_a_appears_before_b(S, true).

check_if_all_a_appears_before_b([], _) ->
  true;
check_if_all_a_appears_before_b([$a | T], AllA) ->
  check_if_all_a_appears_before_b(T, AllA);
check_if_all_a_appears_before_b([$b | T], true) ->
  check_if_all_a_appears_before_b(T, false);
check_if_all_a_appears_before_b([$b | _], false) ->
  true;
check_if_all_a_appears_before_b(_, _) ->
  false.