-module(solution).
-export([zero_even_odd/1]).

zero_even_odd(N) ->
    P = spawn(fun() -> print(0, N) end),
    spawn(fun() -> print_even(N, P) end),
    spawn(fun() -> print_odd(N, P) end),
    P.

print(0, N) ->
    lists:foreach(fun(_) -> io:format("0~n"), timer:sleep(1000) end, lists:seq(1, N)).

print_even(N, P) ->
    lists:foreach(fun(X) -> 
        if 
            X rem 2 =:= 0 -> 
                io:format("~p~n", [X]), 
                timer:sleep(1000), 
                P ! {print, 0} 
        end 
    end, lists:seq(1, N)).

print_odd(N, P) ->
    lists:foreach(fun(X) -> 
        if 
            X rem 2 =:= 1 -> 
                io:format("~p~n", [X]), 
                timer:sleep(1000), 
                P ! {print, 0} 
        end 
    end, lists:seq(1, N)).