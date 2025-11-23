-module(solution).
-export([countAndSay/1]).

countAndSay(1) -> "1";
countAndSay(N) when N > 1 ->
    Prev = countAndSay(N - 1),
    say_one_step(Prev).

say_one_step([]) -> [];
say_one_step([H | T]) ->
    {Count, Rest} = count_consecutive(H, T, 1),
    [Count + $0, H | say_one_step(Rest)].

count_consecutive(Char, [Char | T], Acc) ->
    count_consecutive(Char, T, Acc + 1);
count_consecutive(_Char, OtherList, Acc) ->
    {Acc, OtherList}.