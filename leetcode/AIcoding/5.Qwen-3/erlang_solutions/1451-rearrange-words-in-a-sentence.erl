-module(rearrange_words_in_a_sentence).
-export([reorder/1]).

reorder(S) ->
    Words = string:split(S, " ", all),
    SortedWords = lists:sort(fun(A, B) -> length(A) < length(B) end, Words),
    lists:foldl(fun(W, Acc) -> Acc ++ [W] ++ [" "] end, "", SortedWords) -- [" "].

strip_trailing_space([]) -> [];
strip_trailing_space([H|T]) when H == $  -> strip_trailing_space(T);
strip_trailing_space([H|T]) -> [H | strip_trailing_space(T)].