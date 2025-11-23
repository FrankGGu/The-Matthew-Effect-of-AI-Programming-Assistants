-module(find_max_marked_indices).
-export([max_marked_indices/1]).

max_marked_indices(Nums) ->
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),
    {max_marked_indices_helper(SortedNums, 0, N div 2, 0), N}.

max_marked_indices_helper(Nums, I, J, Count) ->
    case I >= length(Nums) div 2 or J >= length(Nums) of
        true ->
            Count;
        false ->
            if 2 * lists:nth(I, Nums) =< lists:nth(J, Nums) then
                max_marked_indices_helper(Nums, I + 1, J + 1, Count + 2)
            else
                max_marked_indices_helper(Nums, I, J + 1, Count)
            end
    end.