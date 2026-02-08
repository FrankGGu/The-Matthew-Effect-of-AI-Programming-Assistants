-module(find_maximum_non_decreasing_array_length).
-export([find_maximum_length/1]).

find_maximum_length(Nums) ->
    find_maximum_length(Nums, 0, 0, []).

find_maximum_length([], _, _, Acc) ->
    length(Acc);
find_maximum_length([H|T], Sum, Prev, Acc) ->
    case Sum + H >= Prev of
        true ->
            find_maximum_length(T, 0, Sum + H, [Sum + H | Acc]) + 1;
        false ->
            Max1 = find_maximum_length(T, Sum + H, Prev, Acc),
            Max2 = find_maximum_length(T, 0, 0, Acc),
            max(Max1, Max2)
    end.