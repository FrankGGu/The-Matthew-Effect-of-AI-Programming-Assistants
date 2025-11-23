-module(recent_counter).
-export([start/0, ping/1]).

start() ->
    ets:new(recent_calls, [set, public, named_table]).

ping(t) ->
    ets:insert(recent_calls, {t}),
    remove_old(t),
    ets:info(recent_calls, size).

remove_old(t) ->
    ets:select(recent_calls, [{'$1', '$1', '$2', true, [{'>', '$1', t - 3000}], ['delete']}]).