-module(solution).
-export([minimizeMax/2]).

minimizeMax(Nums, P) ->
    SortedNums = lists:sort(Nums),

    Low = 0,
    High = case SortedNums of
               [] -> 0;
               [H | T] -> lists:last(SortedNums) - H
           end,

    binary_search(SortedNums, P, Low, High, High).

binary_search(_SortedNums, _P, Low, High, Ans) when Low > High ->
    Ans;
binary_search(SortedNums, P, Low, High, Ans) ->
    Mid = Low + (High - Low) div 2,
    case check(SortedNums, P, Mid) of
        true ->
            binary_search(SortedNums, P, Low, Mid - 1, Mid);
        false ->
            binary_search(SortedNums, P, Mid + 1, High, Ans)
    end.

check(SortedNums, P, Diff) ->
    check_impl(SortedNums, P, Diff, 0).

check_impl(_SortedNums, P, _Diff, Count) when Count >= P ->
    true;
check_impl([_], _P, _Diff, _Count) ->
    false;
check_impl([], _P, _Diff, _Count) ->
    false;
check_impl([H1, H2 | T], P, Diff, Count) ->
    case H2 - H1 =< Diff of
        true ->
            check_impl(T, P, Diff, Count + 1);
        false ->
            check_impl([H2 | T], P, Diff, Count)
    end.