-module(h2o).
-export([start/0, init/0, hydrogen/1, oxygen/1]).

start() ->
    spawn(?MODULE, init, []).

init() ->
    loop(0, 0).

loop(H, O) when H >= 2, O >= 1 ->
    io:format("HHO~n"),
    loop(H - 2, O - 1);
loop(H, O) ->
    receive
        {hydrogen, Pid} ->
            Pid ! ok,
            loop(H + 1, O);
        {oxygen, Pid} ->
            Pid ! ok,
            loop(H, O + 1)
    end.

hydrogen(H2O) ->
    H2O ! {hydrogen, self()},
    receive ok -> ok end.

oxygen(H2O) ->
    H2O ! {oxygen, self()},
    receive ok -> ok end.