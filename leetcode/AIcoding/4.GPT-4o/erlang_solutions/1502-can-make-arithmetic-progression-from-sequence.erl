-module(solution).
-export([can_make_arithmetic_progression/1]).

can_make_arithmetic_progression(Seq) ->
    Sorted = lists:sort(Seq),
    N = length(Sorted),
    if 
        N < 2 -> true;
        true -> 
            Diff = lists:nth(2, Sorted) - lists:nth(1, Sorted),
            check_diff(Sorted, Diff, 2)
    end.

check_diff([], _, _) -> true;
check_diff([_], _, _) -> true;
check_diff([H1, H2 | T], Diff, Index) ->
    if 
        H2 - H1 =:= Diff -> check_diff([H2 | T], Diff, Index + 1);
        true -> false
    end.