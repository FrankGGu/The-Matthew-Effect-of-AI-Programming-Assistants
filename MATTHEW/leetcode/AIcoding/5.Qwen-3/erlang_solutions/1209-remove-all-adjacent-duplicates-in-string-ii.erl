-module(remove_all_adjacent_duplicates_in_string_ii).
-export([removeDuplicates/2]).

removeDuplicates(Str, K) ->
    removeDuplicates(Str, K, []).

removeDuplicates([], _K, Acc) ->
    lists:reverse(Acc);
removeDuplicates([C | Rest], K, [{C, Count} | Acc]) when Count + 1 == K ->
    removeDuplicates(Rest, K, Acc);
removeDuplicates([C | Rest], K, [{C, Count} | Acc]) ->
    removeDuplicates(Rest, K, [{C, Count + 1} | Acc]);
removeDuplicates([C | Rest], K, Acc) ->
    removeDuplicates(Rest, K, [{C, 1} | Acc]).