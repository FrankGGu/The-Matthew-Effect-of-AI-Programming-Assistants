-module(k_special).
-export([min_deletions/2]).

min_deletions(S, K) ->
    Counts = count_chars(S),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, Counts),
    List = [X || {_, X} <- Sorted],
    do_min_deletions(List, K, 0).

do_min_deletions([], _, Acc) ->
    Acc;
do_min_deletions([H | T], K, Acc) when H >= K ->
    do_min_deletions(T, K, Acc);
do_min_deletions([H | T], K, Acc) ->
    do_min_deletions(T, K, Acc + (H - K)).

count_chars(S) ->
    count_chars(S, #{}).

count_chars([], Acc) ->
    maps:to_list(Acc);
count_chars([C | T], Acc) ->
    NewAcc = case maps:is_key(C, Acc) of
        true -> maps:update(C, maps:get(C, Acc) + 1, Acc);
        false -> maps:put(C, 1, Acc)
    end,
    count_chars(T, NewAcc).