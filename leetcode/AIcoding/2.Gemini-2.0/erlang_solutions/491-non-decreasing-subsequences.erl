-module(non_decreasing_subsequences).
-export([find_subsequences/1]).

find_subsequences(Nums) ->
    find_subsequences_helper(Nums, [], sets:new()).

find_subsequences_helper([], _, Acc) ->
    sets:to_list(Acc);
find_subsequences_helper([H|T], Curr, Acc) ->
    Acc1 = find_subsequences_helper(T, Curr, Acc),
    case Curr of
        [] ->
            Acc2 = find_subsequences_helper(T, [H], Acc1),
            Acc2;
        [Last|_] ->
            if H >= Last then
                Subsequence = lists:reverse([H|Curr]),
                Acc3 = sets:add_element(Subsequence, Acc1),
                find_subsequences_helper(T, [H|Curr], Acc3)
            else
                Acc1
            end
    end.