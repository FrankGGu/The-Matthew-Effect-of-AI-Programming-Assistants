-module(solution).
-export([new/0, set/3, get/2]).

new() ->
    dict:new().

set(Key, Value, Timestamp) ->
    Dict = new(),
    case dict:is_key(Key, Dict) of
        true ->
            List = dict:fetch(Key, Dict),
            UpdatedList = lists:sort([{Timestamp, Value} | List]),
            dict:store(Key, UpdatedList, Dict);
        false ->
            dict:store(Key, [{Timestamp, Value}], Dict)
    end.

get(Key, Timestamp) ->
    Dict = new(),
    case dict:is_key(Key, Dict) of
        true ->
            List = dict:fetch(Key, Dict),
            SortedList = lists:reverse(lists:sort(List)),
            find_value(SortedList, Timestamp);
        false ->
            undefined
    end.

find_value([], _) ->
    undefined;
find_value([{T, V} | _], Timestamp) when T =< Timestamp ->
    V;
find_value([_|Rest], Timestamp) ->
    find_value(Rest, Timestamp).