-module(TimeMap).
-export([new/0, set/3, get/2]).

new() ->
    {ok, #{}}.

set(State, Key, Value, Timestamp) ->
    NewMap = maps:update(Key, [{Value, Timestamp} | maps:get(Key, State, [])], State),
    {ok, NewMap}.

get(State, Key, Timestamp) ->
    case maps:get(Key, State, []) of
        [] -> {error};
        Values -> 
            lists:foldl(fun({Value, Time}, Acc) -> 
                if 
                    Time =< Timestamp -> lists:append(Acc, [Value]);
                    true -> Acc
                end 
            end, [], Values) 
            |> lists:last()
    end.