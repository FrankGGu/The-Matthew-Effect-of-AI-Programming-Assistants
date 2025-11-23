-module(solution).
-export([find_losers/2]).

find_losers(N, k) ->
    Players = lists:seq(1, N),
    play(Players, k, 1).

play([], _, _) ->
    [];
play([Winner], _, _) ->
    [Winner];
play(Players, K, Index) ->
    {Removed, Remaining} = remove_at_index(Index, Players),
    play(Remaining, K, (Index + K - 1) rem length(Remaining) + 1).

remove_at_index(I, List) ->
    {lists:nth(I, List), lists:sublist(List, I-1) ++ lists:sublist(List, I+1, length(List)-I)}.