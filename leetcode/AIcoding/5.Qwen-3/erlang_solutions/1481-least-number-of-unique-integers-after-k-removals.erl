-module(least_number_of_unique_integers_after_k_removals).
-export([find_least_num_of_unique_ints/2]).

find_least_num_of_unique_ints(Nums, K) ->
    CountMap = count_numbers(Nums, #{}),
    SortedCounts = lists:sort(fun({_, A}, {_, B}) -> A =< B end, maps:to_list(CountMap)),
    remove_k(SortedCounts, K, maps:size(CountMap)).

count_numbers([], Acc) ->
    Acc;
count_numbers([H | T], Acc) ->
    Count = maps:get(H, Acc, 0),
    count_numbers(T, maps:put(H, Count + 1, Acc)).

remove_k([], _, Result) ->
    Result;
remove_k([{_Number, 1} | T], K, Result) when K > 0 ->
    remove_k(T, K - 1, Result - 1);
remove_k([{_Number, Count} | T], K, Result) when Count =< K ->
    remove_k(T, K - Count, Result - 1);
remove_k([{_Number, Count} | T], K, Result) ->
    remove_k(T, K, Result).