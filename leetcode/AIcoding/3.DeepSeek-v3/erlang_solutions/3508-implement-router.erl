-module(router).
-export([init/0, add_route/2, route/1]).

init() ->
    spawn(fun() -> loop([]) end).

add_route(RouterPid, {Path, Handler}) ->
    RouterPid ! {add, Path, Handler}.

route(RouterPid, Path) ->
    RouterPid ! {route, self(), Path},
    receive
        {response, Handler} -> Handler
    end.

loop(Routes) ->
    receive
        {add, Path, Handler} ->
            loop([{Path, Handler} | Routes]);
        {route, From, Path} ->
            case lists:keyfind(Path, 1, Routes) of
                {Path, Handler} ->
                    From ! {response, Handler};
                false ->
                    From ! {response, not_found}
            end,
            loop(Routes)
    end.