-module(solution).
-export([countAndSay/1]).

countAndSay(1) ->
    "1";
countAndSay(N) when N > 1 ->
    PrevResult = countAndSay(N - 1),
    say_string(PrevResult).

say_string([]) ->
    [];
say_string([H | T]) ->
    {Count, Rest} = count_consecutive(H, T, 1),
    integer_to_list(Count) ++ [H] ++ say_string(Rest).

count_consecutive(Char, [], Count) ->
    {Count, []};
count_consecutive(Char, [Char | T], Count) ->
    count_consecutive(Char, T, Count + 1);
count_consecutive(Char, OtherT, Count) ->
    {Count, OtherT}.