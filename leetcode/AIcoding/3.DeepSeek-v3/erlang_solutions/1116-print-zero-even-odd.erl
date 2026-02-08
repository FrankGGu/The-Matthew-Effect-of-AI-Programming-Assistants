-module(zero_even_odd).
-export([main/1, zero/4, even/4, odd/4]).

main(N) ->
    spawn(zero_even_odd, zero, [N, self(), undefined, undefined]),
    receive
        {zero_pid, ZeroPid} ->
            spawn(zero_even_odd, even, [N, ZeroPid, undefined, self()]),
            spawn(zero_even_odd, odd, [N, ZeroPid, undefined, self()]),
            receive
                done -> ok
            after
                1000 -> ok
            end
    end.

zero(N, MainPid, EvenPid, OddPid) ->
    MainPid ! {zero_pid, self()},
    zero_loop(N, 1, EvenPid, OddPid, MainPid).

zero_loop(N, I, EvenPid, OddPid, MainPid) when I > N ->
    MainPid ! done;
zero_loop(N, I, EvenPid, OddPid, MainPid) ->
    io:format("0"),
    case I rem 2 of
        0 ->
            EvenPid ! {print, I},
            receive
                {even_done} -> ok
            end;
        1 ->
            OddPid ! {print, I},
            receive
                {odd_done} -> ok
            end
    end,
    zero_loop(N, I + 1, EvenPid, OddPid, MainPid).

even(N, ZeroPid, _, MainPid) ->
    receive
        {print, I} ->
            io:format("~p", [I]),
            ZeroPid ! {even_done},
            even(N, ZeroPid, undefined, MainPid)
    end.

odd(N, ZeroPid, _, MainPid) ->
    receive
        {print, I} ->
            io:format("~p", [I]),
            ZeroPid ! {odd_done},
            odd(N, ZeroPid, undefined, MainPid)
    end.