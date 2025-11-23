-module(print_in_order).
-export([first/1, second/1, third/1]).

-record(state, {first_done = false, second_done = false, m}).

start() ->
    M = ets:new(order_state, [named_table, public, set]),
    ets:insert(M, {#state{}, #state{m = M}}),
    M.

first(M) ->
    io:format("first~n"),
    ets:update_element(M, {#state{}, 1}, {#state{first_done = true}, #state{}}),
    ok.

second(M) ->
    wait_for_first(M),
    io:format("second~n"),
    ets:update_element(M, {#state{}, 1}, {#state{second_done = true}, #state{}}),
    ok.

third(M) ->
    wait_for_second(M),
    io:format("third~n"),
    ok.

wait_for_first(M) ->
    case ets:lookup(M, #state{}) of
        [{#state{first_done = true}, _}] ->
            ok;
        _ ->
            timer:sleep(1),
            wait_for_first(M)
    end.

wait_for_second(M) ->
    case ets:lookup(M, #state{}) of
        [{#state{first_done = true, second_done = true}, _}] ->
            ok;
        _ ->
            timer:sleep(1),
            wait_for_second(M)
    end.