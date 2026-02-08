-module(binary_watch).
-export([read_binary_watch/1]).

read_binary_watch(Num) ->
    generate_hours_and_minutes(Num).

generate_hours_and_minutes(Num) ->
    Hours = lists:seq(0, 11),
    Minutes = lists:seq(0, 59),
    [format_time(H, M) || H <- Hours, M <- Minutes, count_bits(H) + count_bits(M) == Num].

count_bits(N) ->
    count_bits(N, 0).

count_bits(0, Count) ->
    Count;
count_bits(N, Count) ->
    count_bits(N div 2, Count + (N rem 2)).

format_time(H, M) ->
    HourStr = integer_to_list(H),
    MinStr = case M of
        M when M < 10 -> "0" ++ integer_to_list(M);
        _ -> integer_to_list(M)
    end,
    HourStr ++ ":" ++ MinStr.