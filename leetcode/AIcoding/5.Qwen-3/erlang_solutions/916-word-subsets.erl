-module(word_subsets).
-export([word_subsets/2]).

word_subsets(Words, Xs) ->
    XCount = count_chars(lists:foldl(fun(X, Acc) -> merge_counts(Acc, count_chars(X)) end, #{}, Xs)),
    [W || W <- Words, is_subset(W, XCount)].

count_chars(Str) ->
    count_chars(Str, #{}).

count_chars([], Acc) ->
    Acc;
count_chars([C | Rest], Acc) ->
    Count = maps:get(C, Acc, 0),
    count_chars(Rest, maps:put(C, Count + 1, Acc)).

merge_counts(Acc, Next) ->
    maps:merge_with(fun(_, A, B) -> max(A, B) end, Acc, Next).

is_subset(W, XCount) ->
    WCount = count_chars(W),
    is_subset_helper(WCount, XCount).

is_subset_helper(WCount, XCount) ->
    lists:all(fun({K, V}) -> maps:get(K, WCount, 0) >= V end, maps:to_list(XCount)).