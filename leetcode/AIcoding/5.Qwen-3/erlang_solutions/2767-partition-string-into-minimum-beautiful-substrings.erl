-module(partition_string_into_minimum_beautiful_substrings).
-export([min_partitions/1]).

min_partitions(S) ->
    min_partitions(S, 0, 0, 0, 256, 0).

min_partitions(_, _, _, _, _, Min) when Min =< 0 ->
    0;
min_partitions(S, Start, End, Count, Max, Min) ->
    case End >= erlang:length(S) of
        true ->
            Min;
        false ->
            case is_beautiful(S, Start, End) of
                true ->
                    NewCount = Count + 1,
                    NewMin = min(Min, NewCount),
                    min_partitions(S, End + 1, End + 1, NewCount, Max, NewMin);
                false ->
                    min_partitions(S, Start, End + 1, Count, Max, Min)
            end
    end.

is_beautiful(S, Start, End) ->
    Length = End - Start,
    if
        Length == 0 ->
            false;
        true ->
            Sub = erlang:substring(S, Start + 1, Length),
            Number = list_to_integer(Sub),
            is_power_of_two(Number)
    end.

is_power_of_two(N) ->
    N > 0 andalso (N band (N - 1)) == 0.