-module(building_h2o).
-export([h2o/0]).

h2o() ->
  spawn(fun() -> oxygen_server() end),
  spawn(fun() -> hydrogen_server() end),
  spawn(fun() -> hydrogen_server() end).

oxygen_server() ->
  receive
    {hydrogen, Pid} ->
      Pid ! ok,
      receive
        {hydrogen, Pid2} ->
          Pid2 ! ok,
          io:format("H2O~n"),
          oxygen_server()
      end
  end.

hydrogen_server() ->
  receive
    oxygen_server ->
      Sender = self(),
      oxygen_server ! {hydrogen, Sender},
      receive
        ok ->
          hydrogen_server()
      end
  end.