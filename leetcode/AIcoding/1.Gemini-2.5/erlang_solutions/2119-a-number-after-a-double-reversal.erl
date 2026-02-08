-module(solution).
-export([is_same_after_reversals/1]).

is_same_after_reversals(0) -> true;
is_same_after_reversals(Num) when Num rem 10 =/= 0 -> true;
is_same_after_reversals(_) -> false.