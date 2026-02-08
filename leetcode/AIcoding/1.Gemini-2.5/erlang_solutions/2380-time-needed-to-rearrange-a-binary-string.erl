-module(solution).
-export([secondsToRemoveOccurrences/1]).

secondsToRemoveOccurrences(S) ->
    ListS = string:to_list(S),
    solve(ListS, 0).

solve(S, Time) ->
    case find_and_swap(S) of
        {no_swaps, _} ->
            Time;
        {swapped, NewS} ->
            solve(NewS, Time + 1)
    end.

find_and_swap(S) ->
    {SwappedThisTurn, ReversedNewS} = find_and_swap_recursive(S, [], false),
    case SwappedThisTurn of
        true -> {swapped, lists:reverse(ReversedNewS)};
        false -> {no_swaps, lists:reverse(ReversedNewS)}
    end.

find_and_swap_recursive([$0, $1 | Rest], RevAcc, _) ->
    find_and_swap_recursive(Rest, [$0, $1 | RevAcc], true);
find_and_swap_recursive([H | T], RevAcc, SwappedThisTurn) ->
    find_and_swap_recursive(T, [H | RevAcc], SwappedThisTurn);
find_and_swap_recursive([], RevAcc, SwappedThisTurn) ->
    {SwappedThisTurn, RevAcc}.