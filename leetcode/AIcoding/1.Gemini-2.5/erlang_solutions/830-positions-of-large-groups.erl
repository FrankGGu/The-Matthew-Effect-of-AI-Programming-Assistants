-module(solution).
-export([large_group_positions/1]).

large_group_positions(S) ->
    large_group_positions(S, 0, []).

large_group_positions([], _CurrentIndex, Acc) ->
    lists:reverse(Acc).
large_group_positions([H|T], CurrentIndex, Acc) ->
    find_group_end([H|T], H, CurrentIndex, CurrentIndex, Acc).

find_group_end([], _Char, GroupStart, CurrentPos, Acc) ->
    GroupLength = CurrentPos - GroupStart,
    NewAcc = if GroupLength >= 3 -> [[GroupStart, CurrentPos - 1] | Acc];
               true -> Acc
             end,
    lists:reverse(NewAcc);
find_group_end([H|T], Char, GroupStart, CurrentPos, Acc) when H == Char ->
    find_group_end(T, Char, GroupStart, CurrentPos + 1, Acc);
find_group_end([H|T], Char, GroupStart, CurrentPos, Acc) ->
    GroupLength = CurrentPos - GroupStart,
    NewAcc = if GroupLength >= 3 -> [[GroupStart, CurrentPos - 1] | Acc];
               true -> Acc
             end,
    find_group_end(T, H, CurrentPos, CurrentPos + 1, NewAcc).