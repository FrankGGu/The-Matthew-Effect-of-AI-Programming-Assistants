-module(zero_even_odd).
-export([run/1]).

run(N) ->
    Zero = spawn(fun() -> zero(N, 0) end),
    Even = spawn(fun() -> even(N, 0) end),
    Odd = spawn(fun() -> odd(N, 0) end),
    Zero ! {self(), start},
    receive
        done -> ok
    after 1000 -> ok
    end.

zero(N, Count) ->
    receive
        {Pid, start} ->
            Pid ! {self(), ready},
            loop_zero(N, Count);
        _ ->
            zero(N, Count)
    end.

loop_zero(N, Count) ->
    case Count of
        N -> Pid ! done;
        _ ->
            io:format("0"),
            Even ! {self(), next},
            receive
                {self(), next} -> loop_even(N, Count + 1)
            end
    end.

loop_even(N, Count) ->
    receive
        {Pid, next} ->
            io:format("~p", [Count]),
            if
                Count < N -> Odd ! {self(), next}, loop_odd(N, Count + 1);
                true -> Pid ! done
            end
    end.

loop_odd(N, Count) ->
    receive
        {Pid, next} ->
            io:format("~p", [Count]),
            if
                Count < N -> Zero ! {self(), next}, loop_zero(N, Count + 1);
                true -> Pid ! done
            end
    end.