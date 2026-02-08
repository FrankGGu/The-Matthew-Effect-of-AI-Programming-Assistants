-module(router).
-export([new/0, add_route/3, remove_route/2, lookup_route/2]).

new() ->
    #{}
.

add_route(Router, Path, Handler) ->
    Router#{Path => Handler}
.

remove_route(Router, Path) ->
    maps:remove(Path, Router)
.

lookup_route(Router, Path) ->
    case maps:find(Path, Router) of
        {ok, Handler} -> Handler;
        error -> undefined
    end
.