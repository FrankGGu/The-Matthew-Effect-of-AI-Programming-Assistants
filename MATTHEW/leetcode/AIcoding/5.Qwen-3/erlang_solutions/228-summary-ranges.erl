-module(summary_ranges).
-export([summary_ranges/1]).

summary_ranges([]) -> [];
summary_ranges([H|T]) ->
    summary_ranges(H, T, [H], []).

summary_ranges(_, [], Current, Acc) ->
    add_range(Current, Acc);
summary_ranges(Prev, [H|T], Current, Acc) when H == Prev + 1 ->
    summary_ranges(H, T, [H | Current], Acc);
summary_ranges(Prev, [H|T], Current, Acc) ->
    NewAcc = add_range(Current, Acc),
    summary_ranges(H, T, [H], NewAcc).

add_range([X], Acc) ->
    [integer_to_list(X) | Acc];
add_range([X,Y], Acc) ->
    [integer_to_list(X) ++ "->" ++ integer_to_list(Y) | Acc];
add_range([X|_], Acc) ->
    [integer_to_list(X) ++ "->" ++ integer_to_list(lists:last([X|[]])) | Acc].