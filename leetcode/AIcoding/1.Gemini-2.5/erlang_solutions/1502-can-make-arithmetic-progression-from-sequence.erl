-module(solution).
-export([canMakeArithmeticProgression/1]).

-spec canMakeArithmeticProgression(Arr :: [integer()]) -> boolean().
canMakeArithmeticProgression(Arr) ->
    SortedArr = lists:sort(Arr),
    check_progression(SortedArr).

check_progression([_]) -> true;
check_progression([H1, H2 | T]) ->
    Diff = H2 - H1,
    check_diff(T, H2, Diff).

check_diff([], _, _) -> true;
check_diff([H | T], Prev, Diff) ->
    case H - Prev of
        Diff -> check_diff(T, H, Diff);
        _ -> false
    end.