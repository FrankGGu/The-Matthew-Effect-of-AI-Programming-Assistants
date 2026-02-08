-module(router).
-export([new/0, add_route/3, remove_route/2, route/2]).

-record(route, {path, handler, method}).

new() ->
    [].

add_route(Routes, Path, Handler, Method) ->
    Route = #route{path=Path, handler=Handler, method=Method},
    [Route | Routes].

remove_route(Routes, Path) ->
    lists:filter(fun(Route) -> Route#route.path =/= Path end, Routes).

route(Routes, Path) ->
    case lists:filter(fun(Route) -> Route#route.path =:= Path end, Routes) of
        [] -> none;
        [Route | _] -> Route#route.handler
    end.