-module(solution).
-export([foo_bar/1]).

-define(MAX_COUNT, 100).

foo_bar(N) when N > 0 ->
    spawn(fun() -> print_foo(N) end),
    spawn(fun() -> print_bar(N) end).

print_foo(N) ->
    lists:foreach(fun(_) -> io:format("Foo~n"), timer:sleep(100) end, lists:seq(1, N)).

print_bar(N) ->
    lists:foreach(fun(_) -> io:format("Bar~n"), timer:sleep(100) end, lists:seq(1, N)).