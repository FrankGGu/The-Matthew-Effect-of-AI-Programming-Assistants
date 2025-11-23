-module(foo).
-export([first/1, second/1, third/1, init/0]).

init() ->
    spawn(fun() -> loop({undefined, undefined, undefined}) end).

loop({First, Second, Third}) ->
    receive
        {first, Pid} when Second =:= undefined, Third =:= undefined ->
            Pid ! ok,
            loop({done, Second, Third});
        {second, Pid} when First =/= undefined, Third =:= undefined ->
            Pid ! ok,
            loop({First, done, Third});
        {third, Pid} when First =/= undefined, Second =/= undefined ->
            Pid ! ok,
            loop({First, Second, done});
        _ ->
            loop({First, Second, Third})
    end.

first(Pid) ->
    Pid ! {first, self()},
    receive ok -> ok end,
    io:format("first").

second(Pid) ->
    Pid ! {second, self()},
    receive ok -> ok end,
    io:format("second").

third(Pid) ->
    Pid ! {third, self()},
    receive ok -> ok end,
    io:format("third").