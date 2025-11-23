-module(tinyurl).
-export([encode/1, decode/1]).

-define(BASE, "http://tinyurl.com/").
-define(SHORT_LEN, 6).

-record(state, {counter = 0}).

encode(URL) ->
    State = case ets:lookup(?MODULE, state) of
                [] -> #state{};
                [S] -> S
            end,
    Short = generate_short(State#state.counter),
    ets:insert(?MODULE, {state, State#state{counter = State#state.counter + 1}}),
    ?BASE ++ Short.

decode(ShortURL) ->
    [_, Short] = string:split(ShortURL, ?BASE),
    case ets:lookup(?MODULE, Short) of
        [] -> "";
        [{Short, URL}] -> URL
    end.

generate_short(N) ->
    Base62 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz",
    generate_short(N, Base62, []).

generate_short(0, _, Acc) ->
    lists:reverse(Acc);
generate_short(N, Base62, Acc) ->
    generate_short(N div 62, Base62, [lists:nth(N rem 62 + 1, Base62) | Acc]).

init() ->
    ets:new(?MODULE, [named_table, public, {read_concurrency, true}]),
    ets:insert(?MODULE, {state, #state{}}).

-on_load(init).