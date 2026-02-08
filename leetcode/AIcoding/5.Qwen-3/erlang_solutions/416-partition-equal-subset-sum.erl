-module(partition_equal_subset_sum).
-export([can_partition/1]).

can_partition(Nums) ->
    Sum = lists:sum(Nums),
    if
        (Sum rem 2) /= 0 -> false;
        true ->
            Target = Sum div 2,
            Set = sets:from_list(Nums),
            can_partition(Nums, Target, 0, Set)
    end.

can_partition([], _, _, _) -> true;
can_partition([H | T], Target, Current, Set) ->
    case Current + H of
        New when New =< Target ->
            case sets:is_element(New, Set) of
                true -> can_partition(T, Target, Current, Set);
                false ->
                    NewSet = sets:add_element(New, Set),
                    can_partition(T, Target, Current, NewSet)
            end;
        _ ->
            can_partition(T, Target, Current, Set)
    end.