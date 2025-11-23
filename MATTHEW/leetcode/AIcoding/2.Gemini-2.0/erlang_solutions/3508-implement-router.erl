-module(router).
-export([start/0, route/2, add_route/3]).

-record(state, {routes = []}).

start() ->
  Pid = spawn(fun() -> loop(#state{}) end),
  {ok, Pid}.

route(Pid, Path) ->
  Pid ! {route, Path, self()},
  receive
    {Pid, Result} -> Result
  end.

add_route(Pid, Path, Handler) ->
  Pid ! {add_route, Path, Handler},
  ok.

loop(State) ->
  receive
    {route, Path, From} ->
      Result = find_route(Path, State#state.routes),
      From ! {self(), Result},
      loop(State);
    {add_route, Path, Handler} ->
      NewRoutes = lists:append(State#state.routes, [{Path, Handler}]),
      loop(State#state{routes = NewRoutes});
    _ ->
      loop(State)
  end.

find_route(Path, Routes) ->
  find_route(Path, Routes, undefined).

find_route(_Path, [], Default) ->
  Default;
find_route(Path, [{RoutePath, Handler} | Rest], Default) ->
  case route_match(Path, RoutePath) of
    true ->
      Handler;
    false ->
      find_route(Path, Rest, Default)
  end.

route_match(Path, RoutePath) ->
  case string:equal(Path, RoutePath) of
    true -> true;
    false -> false
  end.