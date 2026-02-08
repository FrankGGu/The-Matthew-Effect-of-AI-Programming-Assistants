-module(print_in_order).
-export([main/0]).

main() ->
    P1 = spawn(fun() -> loop(1) end),
    P2 = spawn(fun() -> loop(2) end),
    P3 = spawn(fun() -> loop(3) end),
    P1 ! {print, "first"},
    P2 ! {print, "second"},
    P3 ! {print, "third"}.

loop(N) ->
    receive
        {print, Msg} ->
            case N of
                1 -> io:format("first~n"), P2 ! {print, "second"}, P3 ! {print, "third"};
                2 -> io:format("second~n"), P3 ! {print, "third"};
                3 -> io:format("third~n")
            end,
            loop(N)
    end.