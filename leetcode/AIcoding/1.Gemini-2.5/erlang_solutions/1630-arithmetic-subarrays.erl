-module(solution).
-export([checkArithmeticSubarrays/3]).

checkArithmeticSubarrays(Nums, L, R) ->
    lists:map(
        fun({Li, Ri}) ->
            Subarray = lists:sublist(Nums, Li + 1, Ri - Li + 1),
            is_arithmetic(Subarray)
        end,
        lists:zip(L, R)
    ).

is_arithmetic(List) ->
    Len = length(List),
    if Len =< 2 ->
        true;
    true ->
        SortedList = lists:sort(List),
        [H1, H2 | T] = SortedList,
        Diff = H2 - H1,
        check_arith_diff(T, H2, Diff)
    end.

check_arith_diff([], _PrevElement, _ExpectedDiff) ->
    true;
check_arith_diff([H | T], PrevElement, ExpectedDiff) ->
    if H - PrevElement == ExpectedDiff ->
        check_arith_diff(T, H, ExpectedDiff);
    true ->
        false
    end.