-module(solution).
-export([print_zero_even_odd/4]).

print_zero_even_odd(N, ZeroFun, EvenFun, OddFun) ->
    ZeroPid = spawn(fun() -> zero_loop_init(N, ZeroFun) end),
    OddPid = spawn(fun() -> odd_loop_init(N, OddFun) end),
    EvenPid = spawn(fun() -> even_loop_init(N, EvenFun) end),

    ZeroPid ! {init, OddPid, EvenPid},
    OddPid ! {init, ZeroPid},
    EvenPid ! {init, ZeroPid},

    ZeroPid ! {print_zero, 1},
    ok.

zero_loop_init(N, ZeroFun) ->
    receive
        {init, OddPid, EvenPid} ->
            zero_loop(N, ZeroFun, OddPid, EvenPid);
        _ ->
            zero_loop_init(N, ZeroFun)
    end.

zero_loop(N, ZeroFun, OddPid, EvenPid) ->
    receive
        {print_zero, NumToPrint} when NumToPrint =< N ->
            ZeroFun(),
            case NumToPrint rem 2 of
                1 ->
                    OddPid ! {print_odd, NumToPrint};
                0 ->
                    EvenPid ! {print_even, NumToPrint}
            end,
            zero_loop(N, ZeroFun, OddPid, EvenPid);
        {print_zero, NumToPrint} when NumToPrint > N ->
            OddPid ! done,
            EvenPid ! done,
            ok;
        _ ->
            zero_loop(N, ZeroFun, OddPid, EvenPid)
    end.

odd_loop_init(N, OddFun) ->
    receive
        {init, ZeroPid} ->
            odd_loop(N, OddFun, ZeroPid);
        _ ->
            odd_loop_init(N, OddFun)
    end.

odd_loop(N, OddFun, ZeroPid) ->
    receive
        {print_odd, NumToPrint} when NumToPrint =< N ->
            OddFun(NumToPrint),
            ZeroPid ! {print_zero, NumToPrint + 1},
            odd_loop(N, OddFun, ZeroPid);
        done ->
            ok;
        _ ->
            odd_loop(N, OddFun, ZeroPid)
    end.

even_loop_init(N, EvenFun) ->
    receive
        {init, ZeroPid} ->
            even_loop(N, EvenFun, ZeroPid);
        _ ->
            even_loop_init(N, EvenFun)
    end.

even_loop(N, EvenFun, ZeroPid) ->
    receive
        {print_even, NumToPrint} when NumToPrint =< N ->
            EvenFun(NumToPrint),
            ZeroPid ! {print_zero, NumToPrint + 1},
            even_loop(N, EvenFun, ZeroPid);
        done ->
            ok;
        _ ->
            even_loop(N, EvenFun, ZeroPid)
    end.