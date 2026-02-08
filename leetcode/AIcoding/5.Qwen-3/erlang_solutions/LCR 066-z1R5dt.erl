-module(mapper).
-export([map/1]).

map(Commands) ->
    {ok, _, _} = run(Commands, #{}).

run([], Map) ->
    {ok, Map, []};
run([["insert", Key, Value] | T], Map) ->
    run(T, maps:put(Key, Value, Map));
run([["get", Key] | T], Map) ->
    case maps:find(Key, Map) of
        {ok, V} -> run(T, Map, [V]);
        error -> run(T, Map, [])
    end;
run([["delete", Key] | T], Map) ->
    run(T, maps:remove(Key, Map));
run([["hasKey", Key] | T], Map) ->
    run(T, Map, [case maps:find(Key, Map) of {ok, _} -> true; error -> false end]);
run([_ | T], Map) ->
    run(T, Map).

run([], Map, Acc) ->
    {ok, Map, lists:reverse(Acc)};
run([["insert", Key, Value] | T], Map, Acc) ->
    run(T, maps:put(Key, Value, Map), Acc);
run([["get", Key] | T], Map, Acc) ->
    case maps:find(Key, Map) of
        {ok, V} -> run(T, Map, [V | Acc]);
        error -> run(T, Map, [undefined | Acc])
    end;
run([["delete", Key] | T], Map, Acc) ->
    run(T, maps:remove(Key, Map), Acc);
run([["hasKey", Key] | T], Map, Acc) ->
    run(T, Map, [case maps:find(Key, Map) of {ok, _} -> true; error -> false end | Acc]);
run([_ | T], Map, Acc) ->
    run(T, Map, Acc).