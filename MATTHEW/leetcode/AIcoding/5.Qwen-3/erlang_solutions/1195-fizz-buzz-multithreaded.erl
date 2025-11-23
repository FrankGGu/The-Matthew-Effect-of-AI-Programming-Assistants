-module(fizz_buzz).
-export([main/1]).

main(Args) ->
    N = list_to_integer(hd(Args)),
    Fizz = spawn(fun() -> loop("Fizz", 3, N) end),
    Buzz = spawn(fun() -> loop("Buzz", 5, N) end),
    FizzBuzz = spawn(fun() -> loop("FizzBuzz", 15, N) end),
    Number = spawn(fun() -> loop("", 1, N) end),
    receive
        _ -> ok
    after 0 -> ok
    end.

loop(Msg, Div, Max) ->
    loop(Msg, Div, Max, 1).

loop(Msg, Div, Max, I) when I > Max ->
    ok;
loop(Msg, Div, Max, I) ->
    case I rem Div of
        0 ->
            io:format("~s~n", [Msg]),
            loop(Msg, Div, Max, I + 1);
        _ ->
            loop(Msg, Div, Max, I + 1)
    end.