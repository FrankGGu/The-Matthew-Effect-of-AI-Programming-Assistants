-module(solution).
-export([fairCandySwap/2]).

fairCandySwap(A, B) ->
    SumA = lists:sum(A),
    SumB = lists:sum(B),
    Diff = (SumB - SumA) div 2,
    BSet = gb_sets:from_list(B),
    find_pair(A, Diff, BSet).

find_pair([X | Rest], Diff, BSet) ->
    Y = X + Diff,
    case gb_sets:is_member(Y, BSet) of
        true -> [X, Y];
        false -> find_pair(Rest, Diff, BSet)
    end;
find_pair([], _Diff, _BSet) ->
    %% According to problem constraints, a solution is guaranteed.
    %% This case should not be reached.
    error(no_solution_found).