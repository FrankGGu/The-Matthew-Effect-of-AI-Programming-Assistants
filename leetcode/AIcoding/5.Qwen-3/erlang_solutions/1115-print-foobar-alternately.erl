-module(foo_bar).
-export([main/0]).

main() ->
    N = 5,
    FooBar = spawn(fun() -> foo_bar_loop(N, 0) end),
    FooBar ! {self(), start},
    receive
        {FooBar, done} -> ok
    after 1000 -> ok
    end.

foo_bar_loop(N, Count) ->
    receive
        {From, start} ->
            case Count < N of
                true ->
                    io:format("Foo~n"),
                    From ! {self(), next},
                    foo_bar_loop(N, Count + 1);
                false ->
                    From ! {self(), done}
            end;
        {From, next} ->
            case Count < N of
                true ->
                    io:format("Bar~n"),
                    From ! {self(), next2},
                    foo_bar_loop(N, Count + 1);
                false ->
                    From ! {self(), done}
            end;
        {From, next2} ->
            case Count < N of
                true ->
                    io:format("Foo~n"),
                    From ! {self(), next},
                    foo_bar_loop(N, Count + 1);
                false ->
                    From ! {self(), done}
            end
    end.