-module(count_and_say).
-export([countAndSay/1]).

countAndSay(1) -> "1";
countAndSay(N) ->
    Prev = countAndSay(N-1),
    countAndSay(Prev, 0, $0, []).

countAndSay([], _, _, Acc) ->
    lists:reverse(Acc);
countAndSay([H | T], Count, Current, Acc) when H == Current ->
    countAndSay(T, Count + 1, Current, Acc);
countAndSay([H | T], Count, Current, Acc) ->
    countAndSay(T, 1, H, [H, (Count + 48) | Acc]);
countAndSay([H | T], _, _, Acc) ->
    countAndSay(T, 1, H, [H, $1 | Acc]).