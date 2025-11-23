-module(solution).
-export([word_subsets/2]).

word_subsets(A, B) ->
    MaxCount = lists:foldl(fun(X, Acc) -> update_count(X, Acc) end, lists:duplicate(26, 0), B),
    lists:filter(fun(W) -> is_subset(W, MaxCount) end, A).

update_count(Word, Acc) ->
    Count = lists:foldl(fun(C, Acc1) -> Acc1 + 1 end, Acc, lists:map(fun(C) -> char_to_index(C) end, string:to_list(Word))),
    lists:zip_with(fun(X, Y) -> max(X, Y) end, Acc, Count).

char_to_index(Char) ->
    element(1, unicode:characters_to_binary([Char])) - $a.

is_subset(Word, MaxCount) ->
    Count = lists:foldl(fun(C, Acc) -> Acc + 1 end, lists:duplicate(26, 0), lists:map(fun(C) -> char_to_index(C) end, string:to_list(Word))),
    lists:zip_with(fun(X, Y) -> X >= Y end, Count, MaxCount) =:= true.