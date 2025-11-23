-module(russian_doll_envelopes).
-export([max_envelopes/1]).

max_envelopes(Envelopes) ->
    Sorted = lists:sort(fun(A, B) -> 
        if 
            hd(A) < hd(B) -> true;
            hd(A) == hd(B) -> hd(lists:nth(2, A)) > hd(lists:nth(2, B));
            true -> false
        end
    end, Envelopes),
    Heights = [hd(lists:nth(2, E)) || E <- Sorted],
    lis(Heights, []).

lis([], _) -> 0;
lis([H | T], Acc) ->
    case lists:keyfind(H, 1, Acc) of
        false ->
            NewAcc = insert(H, Acc),
            max_length(NewAcc);
        _ ->
            lis(T, Acc)
    end.

insert(X, []) -> [{X, 1}];
insert(X, [{Y, Count} | T]) when X < Y ->
    [{X, 1} | [{Y, Count} | T]];
insert(X, [{Y, Count} | T]) when X == Y ->
    [{Y, Count + 1} | T];
insert(X, [{Y, Count} | T]) ->
    [{Y, Count} | insert(X, T)].

max_length([]) -> 0;
max_length([{_, Count} | T]) ->
    max(Count, max_length(T)).