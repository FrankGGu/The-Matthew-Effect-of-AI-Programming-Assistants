-module(solution).
-export([sum_counts/1]).

sum_counts(Nums) ->
    Len = length(Nums),
    Total = 0,
    sum_counts(Nums, Len, Total).

sum_counts([], _, Total) ->
    Total;
sum_counts([H|T], Len, Total) ->
    {NewTotal, _} = helper([H], T, sets:from_list([H]), 1, Total + 1),
    sum_counts(T, Len - 1, NewTotal).

helper(_, [], _, Count, Total) ->
    {Total + Count * Count, Count};
helper(Sub, [H|T], Set, Count, Total) ->
    case sets:is_element(H, Set) of
        true ->
            helper([H|Sub], T, Set, Count, Total + Count * Count);
        false ->
            NewSet = sets:add_element(H, Set),
            helper([H|Sub], T, NewSet, Count + 1, Total)
    end.