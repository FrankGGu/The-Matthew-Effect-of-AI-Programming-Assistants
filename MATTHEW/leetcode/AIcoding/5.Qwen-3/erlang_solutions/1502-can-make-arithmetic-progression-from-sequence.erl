-module(can_make_arithmetic_progression_from_sequence).
-export([canMakeArithmeticProgression/1]).

canMakeArithmeticProgression(Numbers) ->
    Sorted = lists:sort(Numbers),
    [H | T] = Sorted,
    Diff = H - lists:last(Sorted),
    check(T, H, Diff).

check([], _, _) -> true;
check([N | T], Prev, Diff) ->
    if
        (N - Prev) == Diff -> check(T, N, Diff);
        true -> false
    end.