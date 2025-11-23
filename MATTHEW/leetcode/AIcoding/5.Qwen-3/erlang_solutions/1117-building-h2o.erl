-module(h2o).
-export([run/0]).

run() ->
    Self = self(),
    H1 = spawn(fun() -> h_process(Self) end),
    H2 = spawn(fun() -> h_process(Self) end),
    O = spawn(fun() -> o_process(Self) end),
    H1 ! {self(), h},
    H2 ! {self(), h},
    O ! {self(), o},
    receive
        {Self, done} -> ok
    after 1000 -> error(timeout)
    end.

h_process(Parent) ->
    receive
        {Parent, h} ->
            Parent ! {self(), h},
            h_process(Parent);
        {Parent, done} ->
            Parent ! {self(), done}
    end.

o_process(Parent) ->
    receive
        {Parent, o} ->
            Parent ! {self(), o},
            o_process(Parent);
        {Parent, done} ->
            Parent ! {self(), done}
    end.