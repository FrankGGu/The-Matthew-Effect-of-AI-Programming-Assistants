-module(partition_string).
-export([min_beautiful_substrings/1]).

min_beautiful_substrings(S) ->
    min_beautiful_substrings(S, 0).

min_beautiful_substrings([], Count) ->
    Count;
min_beautiful_substrings(S, Count) ->
    N = length(S),
    case find_beautiful_prefix(S) of
        none ->
            -1;
        {Prefix, Remainder} ->
            min_beautiful_substrings(Remainder, Count + 1)
    end.

find_beautiful_prefix(S) ->
    N = length(S),
    find_beautiful_prefix(S, 1).

find_beautiful_prefix(S, Len) when Len > length(S) ->
    none;
find_beautiful_prefix(S, Len) ->
    Prefix = lists:sublist(S, 1, Len),
    case is_beautiful(Prefix) of
        true ->
            Remainder = lists:sublist(S, Len + 1, length(S) - Len),
            {Prefix, Remainder};
        false ->
            find_beautiful_prefix(S, Len + 1)
    end.

is_beautiful(S) ->
    case S of
        [] ->
            false;
        [$'0'|_] ->
            false;
        _ ->
            try
                Value = binary_to_integer(list_to_binary(S), 2),
                is_power_of_five(Value)
            catch
                _:_ ->
                    false
            end
    end.

is_power_of_five(1) ->
    true;
is_power_of_five(N) when N < 1 ->
    false;
is_power_of_five(N) ->
    case N rem 5 of
        0 ->
            is_power_of_five(N div 5);
        _ ->
            false
    end.