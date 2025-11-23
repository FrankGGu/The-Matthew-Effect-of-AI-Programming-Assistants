-module(time_based_kv).
-export([new/0, set/3, get/2]).

new() ->
    dict:new().

set(Dict, Key, Value, Timestamp) ->
    case dict:is_key(Key, Dict) of
        true ->
            dict:update(Key, [{Timestamp, Value} | dict:fetch(Key, Dict)], Dict);
        false ->
            dict:store(Key, [{Timestamp, Value}], Dict)
    end.

get(Dict, Key, Timestamp) ->
    case dict:is_key(Key, Dict) of
        true ->
            get_value(dict:fetch(Key, Dict), Timestamp);
        false ->
            ""
    end.

get_value(List, Timestamp) ->
    get_value(List, Timestamp, "").

get_value([], _, Acc) ->
    Acc;

get_value([{T, V} | Rest], Timestamp, Acc) ->
    if
        T =< Timestamp ->
            get_value(Rest, Timestamp, V);
        true ->
            Acc
    end.