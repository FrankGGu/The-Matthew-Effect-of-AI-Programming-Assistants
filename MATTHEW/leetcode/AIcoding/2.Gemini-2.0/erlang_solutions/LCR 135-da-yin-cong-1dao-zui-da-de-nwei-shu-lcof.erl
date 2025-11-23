-module(count_and_say).
-export([count_and_say/1]).

count_and_say(1) -> "1";
count_and_say(N) ->
    count_and_say_helper(count_and_say(N - 1)).

count_and_say_helper(Str) ->
    count_and_say_helper(Str, [], [], 1).

count_and_say_helper([], Acc, Current, Count) ->
    lists:reverse(Acc ++ [integer_to_list(Count), hd(Current)]);
count_and_say_helper([H|T], Acc, [], Count) ->
    count_and_say_helper(T, Acc, [H], Count);
count_and_say_helper([H|T], Acc, [CurrentH| _], Count) when H == CurrentH ->
    count_and_say_helper(T, Acc, [CurrentH], Count + 1);
count_and_say_helper([H|T], Acc, Current, Count) ->
    count_and_say_helper(T, Acc ++ [integer_to_list(Count), hd(Current)], [H], 1).