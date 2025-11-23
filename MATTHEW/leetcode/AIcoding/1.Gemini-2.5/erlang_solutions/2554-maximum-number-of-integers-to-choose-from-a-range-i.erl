-module(solution).
-export([max_count/3]).

max_count(Banned, N, MaxSum) ->
    BannedSet = sets:from_list(Banned),
    max_count_recursive(1, N, MaxSum, BannedSet, 0, 0).

max_count_recursive(CurrentNum, N, MaxSum, BannedSet, CurrentSum, Count) when CurrentNum =< N ->
    case sets:is_element(CurrentNum, BannedSet) of
        true ->
            max_count_recursive(CurrentNum + 1, N, MaxSum, BannedSet, CurrentSum, Count);
        false ->
            IfNewSum = CurrentSum + CurrentNum,
            if IfNewSum =< MaxSum ->
                max_count_recursive(CurrentNum + 1, N, MaxSum, BannedSet, IfNewSum, Count + 1);
            true ->
                Count
            end
    end;
max_count_recursive(_CurrentNum, _N, _MaxSum, _BannedSet, _CurrentSum, Count) ->
    Count.