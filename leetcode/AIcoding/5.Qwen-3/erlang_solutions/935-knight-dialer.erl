-module(knight_dialer).
-export([numberOfPatterns/1]).

numberOfPatterns(N) ->
    Max = 10,
    DP = array:new(Max, {default, 0}),
    array:set(0, 1, DP),
    array:set(1, 1, DP),
    array:set(2, 1, DP),
    array:set(3, 1, DP),
    array:set(4, 1, DP),
    array:set(5, 1, DP),
    array:set(6, 1, DP),
    array:set(7, 1, DP),
    array:set(8, 1, DP),
    array:set(9, 1, DP),
    for(2, N, DP).

for(K, N, DP) when K > N ->
    sum(array:to_list(DP));
for(K, N, DP) ->
    NewDP = array:new(10, {default, 0}),
    for_digit(0, K, DP, NewDP),
    for_digit(1, K, DP, NewDP),
    for_digit(2, K, DP, NewDP),
    for_digit(3, K, DP, NewDP),
    for_digit(4, K, DP, NewDP),
    for_digit(5, K, DP, NewDP),
    for_digit(6, K, DP, NewDP),
    for_digit(7, K, DP, NewDP),
    for_digit(8, K, DP, NewDP),
    for_digit(9, K, DP, NewDP),
    for(K + 1, N, NewDP).

for_digit(Digit, K, DP, NewDP) ->
    Next = case Digit of
        0 -> [4,6];
        1 -> [6,8];
        2 -> [7,9];
        3 -> [4,8];
        4 -> [0,3,9];
        5 -> [];
        6 -> [0,1,7];
        7 -> [2,6];
        8 -> [1,3];
        9 -> [2,4]
    end,
    Val = array:get(Digit, DP),
    lists:foreach(fun(NextDigit) -> NewDP = array:set(NextDigit, array:get(NextDigit, NewDP) + Val, NewDP) end, Next),
    ok.

sum(List) ->
    lists:sum(List).