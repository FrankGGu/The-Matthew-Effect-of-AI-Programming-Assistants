-module(solution).
-export([count_and_say/1]).

count_and_say(N) when N > 0 ->
    count_and_say_helper(N, "1").

count_and_say_helper(1, Say) ->
    Say;
count_and_say_helper(N, Say) ->
    Next = next_say(Say),
    count_and_say_helper(N - 1, Next).

next_say(Say) ->
    next_say_helper(Say, <<>>, 0, <<>>).

next_say_helper(<<>>, Acc, _, _) ->
    <<Acc/binary>>;
next_say_helper(<<H:8, T/binary>>, Acc, Count, Prev) when H =:= Prev ->
    next_say_helper(T, Acc, Count + 1, H);
next_say_helper(<<H:8, T/binary>>, Acc, Count, Prev) ->
    NewAcc = <<Acc/binary, Count:8, Prev:8>>,
    next_say_helper(T, NewAcc, 1, H).

next_say_helper(<<H:8, T/binary>>, Acc, Count, _) ->
    next_say_helper(<<>>, Acc, Count, H).