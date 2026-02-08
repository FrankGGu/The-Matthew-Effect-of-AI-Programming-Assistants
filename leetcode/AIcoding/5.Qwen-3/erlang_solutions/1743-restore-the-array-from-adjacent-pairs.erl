-module(restore_array_from_adjacent_pairs).
-export([recoverArray/1]).

recoverArray(Pairs) ->
    Map = build_map(Pairs),
    [Start | _] = find_start(Map),
    recover_array(Map, Start, []).

build_map(Pairs) ->
    lists:foldl(fun({A, B}, Acc) ->
        Acc1 = add_to_map(Acc, A, B),
        add_to_map(Acc1, B, A)
    end, dict:new(), Pairs).

add_to_map(Dict, Key, Value) ->
    case dict:find(Key, Dict) of
        {ok, List} -> dict:store(Key, [Value | List], Dict);
        error -> dict:store(Key, [Value], Dict)
    end.

find_start(Map) ->
    lists:filter(fun(K) -> length(dict:fetch(K, Map)) == 1 end, dict:keys(Map)).

recover_array(_Map, Current, [Prev | _] = Result) when Prev == lists:last(Result) ->
    Result;
recover_array(Map, Current, Result) ->
    Next = lists:hd(dict:fetch(Current, Map)),
    NewResult = Result ++ [Next],
    recover_array(Map, Next, NewResult).