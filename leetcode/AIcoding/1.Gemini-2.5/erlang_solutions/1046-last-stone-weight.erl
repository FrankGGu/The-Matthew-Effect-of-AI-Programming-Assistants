-module(solution).
-export([lastStoneWeight/1]).

lastStoneWeight(Stones) ->
    SortedStones = lists:reverse(lists:sort(Stones)),
    smash(SortedStones).

smash([]) -> 0;
smash([S]) -> S;
smash([Y, X | Rest]) ->
    Diff = Y - X,
    if
        Diff == 0 ->
            smash(Rest);
        true ->
            NewStones = insert_sorted_desc(Diff, Rest),
            smash(NewStones)
    end.

insert_sorted_desc(E, []) -> [E];
insert_sorted_desc(E, [H | T]) when E >= H -> [E, H | T];
insert_sorted_desc(E, [H | T]) -> [H | insert_sorted_desc(E, T)].