-module(maximum_consecutive_floors).
-export([maxConsecutive/3]).

maxConsecutive(Top, Bottom, Special) ->
    SortedSpecial = lists:sort(Special),
    maxConsecutiveHelper(Top, Bottom, SortedSpecial).

maxConsecutiveHelper(Top, Bottom, []) ->
    Top - Bottom + 1;
maxConsecutiveHelper(Top, Bottom, [H|T]) ->
    Max1 = H - Bottom,
    Max2 = Top - lists:last([H|T]),
    MaxMid = maxConsecutiveMid([H|T]),
    max(Max1, max(Max2, MaxMid)).

maxConsecutiveMid([]) ->
    0;
maxConsecutiveMid([_]) ->
    0;
maxConsecutiveMid([H1, H2|T]) ->
    MaxMidTail = maxConsecutiveMid([H2|T]),
    max(H2 - H1 - 1, MaxMidTail).

max(A, B) ->
    if A > B -> A;
    true -> B
    end.