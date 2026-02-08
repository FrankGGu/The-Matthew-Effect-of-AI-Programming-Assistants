-module(minimum_seconds).
-export([minimum_seconds/1]).

minimum_seconds(Heights) ->
    Len = length(Heights),
    maximum_seconds(Heights, Len).

maximum_seconds(Heights, Len) ->
    Values = lists:usort(Heights),
    Groups = group_by_value(Heights, Values),

    lists:foldl(fun({Value, Indices}, Acc) ->
        MaxDist = calculate_max_distance(Indices, Len),
        Acc + min(MaxDist, Value)
    end, 0, Groups).

group_by_value(Heights, Values) ->
    lists:map(fun(Value) ->
        Indices = find_indices(Heights, Value, []),
        {Value, Indices}
    end, Values).

find_indices(Heights, Value, Acc) ->
    find_indices(Heights, Value, 0, Acc).

find_indices([], _, _, Acc) ->
    lists:reverse(Acc);
find_indices([H | Rest], Value, Index, Acc) ->
    if H == Value ->
        find_indices(Rest, Value, Index + 1, [Index | Acc]);
    true ->
        find_indices(Rest, Value, Index + 1, Acc)
    end.

calculate_max_distance(Indices, Len) ->
    First = lists:nth(1, Indices),
    Last = lists:last(Indices),
    min(Last - First, Len - Last + First).