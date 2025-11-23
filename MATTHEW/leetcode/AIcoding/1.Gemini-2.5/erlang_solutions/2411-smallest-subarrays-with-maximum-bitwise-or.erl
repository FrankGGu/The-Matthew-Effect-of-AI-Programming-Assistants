-module(solution).
-export([smallestSubarrays/1]).

-include_lib("kernel/include/array.hrl").

smallestSubarrays(Nums) ->
    N = length(Nums),
    LastOccurrences0 = array:new({size, 31}, {default, -1}),
    Ans0 = array:new({size, N}),
    ResultArray = solve_recursive(N - 1, Nums, LastOccurrences0, Ans0),
    array:to_list(ResultArray).

solve_recursive(I, Nums, LastOccurrences, Ans) ->
    if I < 0 ->
        Ans;
    true ->
        Num_I = lists:nth(I + 1, Nums),
        NewLastOccurrences = update_last_occurrences(Num_I, I, LastOccurrences),
        MaxJ = calculate_max_j(I, NewLastOccurrences),
        NewAns = array:set(I, MaxJ - I + 1, Ans),
        solve_recursive(I - 1, Nums, NewLastOccurrences, NewAns)
    end.

update_last_occurrences(Num, Index, LastOccurrences) ->
    lists:foldl(fun(K, AccLastOccurrences) ->
        if ((Num bsr K) band 1) == 1 ->
            array:set(K, Index, AccLastOccurrences);
        true ->
            AccLastOccurrences
        end
    end, LastOccurrences, lists:seq(0, 30)).

calculate_max_j(CurrentI, LastOccurrences) ->
    lists:foldl(fun(K, AccMaxJ) ->
        LO_K = array:get(K, LastOccurrences),
        if LO_K /= -1 ->
            max(AccMaxJ, LO_K);
        true ->
            AccMaxJ
        end
    end, CurrentI, lists:seq(0, 30)).