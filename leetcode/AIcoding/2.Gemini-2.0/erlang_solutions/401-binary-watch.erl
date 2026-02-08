-module(binary_watch).
-export([read_binary_watch/1]).

read_binary_watch(Num) ->
    [time_to_string(H, M) || H <- lists:seq(0, 11), M <- lists:seq(0, 59), count_bits(H * 64 + M) =:= Num].

count_bits(N) ->
    count_bits_helper(N, 0).

count_bits_helper(0, Count) ->
    Count;
count_bits_helper(N, Count) ->
    count_bits_helper(N band (N - 1), Count + 1).

time_to_string(H, M) ->
    io_lib:format("~w:~2.2w", [H, M]).