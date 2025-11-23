-spec count_and_say(N :: integer()) -> unicode:unicode_binary().
count_and_say(1) -> "1";
count_and_say(N) ->
    Previous = count_and_say(N - 1),
    count_and_say_run_length(Previous).

-spec count_and_say_run_length(Input :: unicode:unicode_binary()) -> unicode:unicode_binary().
count_and_say_run_length(Input) ->
    count_and_say_run_length(Input, [], 1, <<>>).

-spec count_and_say_run_length(Input :: unicode:unicode_binary(), Acc :: list(), Count :: integer(), Current :: unicode:unicode_binary()) -> unicode:unicode_binary().
count_and_say_run_length(<<>>, Acc, _, Current) ->
    lists:reverse([Current | Acc]);
count_and_say_run_length(<<H, T/binary>>, Acc, Count, Current) when H =:= hd(T) ->
    count_and_say_run_length(T, Acc, Count + 1, <<Current/binary, H>>);
count_and_say_run_length(<<H, T/binary>>, Acc, Count, Current) ->
    count_and_say_run_length(T, [<<Count:integer, Current/binary>> | Acc], 1, <<H>>).
