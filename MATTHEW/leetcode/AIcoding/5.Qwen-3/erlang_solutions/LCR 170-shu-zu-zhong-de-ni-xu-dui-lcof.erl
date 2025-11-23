-module(offline).
-export([reverse_pairs/1]).

reverse_pairs(List) ->
    reverse_pairs(List, 0).

reverse_pairs([], _) ->
    0;
reverse_pairs([H | T], Acc) ->
    Count = count_greater(H, T),
    reverse_pairs(T, Acc + Count).

count_greater(_, []) ->
    0;
count_greater(X, [Y | Ys]) ->
    if
        X > Y -> 1 + count_greater(X, Ys);
        true -> count_greater(X, Ys)
    end.