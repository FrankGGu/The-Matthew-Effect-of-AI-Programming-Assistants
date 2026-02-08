-module(solution).
-export([check_if_it_is_possible_to_split_array/1]).

-spec check_if_it_is_possible_to_split_array(Nums :: [integer()]) -> boolean().
check_if_it_is_possible_to_split_array(Nums) ->
    N = length(Nums),
    if N < 2 ->
        false;
    true ->
        TotalSum = lists:sum(Nums),
        check_splits_iter(Nums, 0, TotalSum)
    end.

check_splits_iter([], _CurrentSum1, _TotalSum) ->
    false;
check_splits_iter([H | T], CurrentSum1, TotalSum) ->
    NewCurrentSum1 = CurrentSum1 + H,
    if T == [] ->
        false;
    true ->
        Sum2 = TotalSum - NewCurrentSum1,
        if NewCurrentSum1 >= Sum2 ->
            true;
        true ->
            check_splits_iter(T, NewCurrentSum1, TotalSum)
        end
    end.