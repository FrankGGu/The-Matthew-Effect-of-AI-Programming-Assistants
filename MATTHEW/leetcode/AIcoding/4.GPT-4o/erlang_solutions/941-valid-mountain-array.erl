-module(solution).
-export([valid_mountain_array/1]).

valid_mountain_array(Array) when length(Array) < 3 ->
    false;
valid_mountain_array(Array) ->
    Peak = find_peak(Array, 0, 0),
    Peak > 0 andalso Peak < length(Array) - 1 andalso
    is_descending(Array, Peak + 1).

find_peak(Array, Index, Peak) when Index < length(Array) ->
    case lists:nth(Index + 1, Array) > lists:nth(Index, Array) of
        true -> find_peak(Array, Index + 1, Index + 1);
        false -> Peak
    end;
find_peak(_, _, Peak) -> Peak.

is_descending(Array, Index) when Index < length(Array) - 1 ->
    case lists:nth(Index, Array) > lists:nth(Index + 1, Array) of
        true -> is_descending(Array, Index + 1);
        false -> false
    end;
is_descending(_, _) -> true.