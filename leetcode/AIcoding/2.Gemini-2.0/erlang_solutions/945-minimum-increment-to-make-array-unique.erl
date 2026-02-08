-module(minimum_increment).
-export([min_increment_for_unique/1]).

min_increment_for_unique(A) ->
    min_increment_for_unique(A, 0, []).

min_increment_for_unique([], Acc, _) ->
    Acc;
min_increment_for_unique([H|T], Acc, Seen) ->
    case lists:member(H, Seen) of
        true ->
            NewH = find_next_available(H, Seen),
            min_increment_for_unique(T, Acc + (NewH - H), [NewH|Seen]);
        false ->
            min_increment_for_unique(T, Acc, [H|Seen])
    end.

find_next_available(N, Seen) ->
    case lists:member(N, Seen) of
        true ->
            find_next_available(N+1, Seen);
        false ->
            N
    end.