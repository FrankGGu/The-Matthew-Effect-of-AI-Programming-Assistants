-module(solution).
-export([create_sorted_array/1]).

create_sorted_array(Instructions) ->
    create_sorted_array(Instructions, [], 0).

create_sorted_array([], _, Acc) ->
    Acc;
create_sorted_array([H | T], List, Acc) ->
    {Less, Greater} = split(H, List),
    create_sorted_array(T, [H | List], Acc + less_count(Less) + greater_count(Greater)).

split(_, []) ->
    {[], []};
split(X, [H | T]) ->
    if
        X < H ->
            { [X | []], [H | T] };
        X > H ->
            { [H | []], [X | T] };
        true ->
            { [H | []], [X | T] }
    end.

less_count(List) ->
    length(List).

greater_count(List) ->
    length(List).