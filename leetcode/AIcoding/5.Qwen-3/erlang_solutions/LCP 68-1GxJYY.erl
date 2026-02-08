-module(Beautiful_Bouquet).
-export([numWays/1]).

numWays(Rows) ->
    RowsLength = length(Rows),
    MaxFlowers = lists:max(Rows),
    Count = 0,
    numWays(Rows, 0, MaxFlowers, Count).

numWays([], _, _, Count) ->
    Count;
numWays([H|T], Index, MaxFlowers, Count) ->
    if
        H == MaxFlowers ->
            numWays(T, Index + 1, MaxFlowers, Count + 1);
        true ->
            numWays(T, Index + 1, MaxFlowers, Count)
    end.