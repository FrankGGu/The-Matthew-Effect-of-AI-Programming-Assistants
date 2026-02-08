-module(solution).
-export([print_in_order/3]).

print_in_order(A, B, C) ->
    P = spawn(fun() -> io:format("~p~n", [A]) end),
    Q = spawn(fun() -> P ! {self(), B} end),
    R = spawn(fun() -> Q ! {self(), C} end),
    receive
        {_, _} -> ok
    end.