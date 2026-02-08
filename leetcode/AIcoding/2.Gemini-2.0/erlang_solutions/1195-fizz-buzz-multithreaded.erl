-module(fizzbuzz).
-export([fizzbuzz/1]).

fizzbuzz(N) ->
    PidFizz = spawn(fun() -> fizz(N) end),
    PidBuzz = spawn(fun() -> buzz(N) end),
    PidFizzBuzz = spawn(fun() -> fizzbuzz(N) end),
    PidNumber = spawn(fun() -> number(N) end),
    Chan = make_channel(),
    {Port, Send} = Chan,
    [Send ! start || _ <- lists:seq(1, 4)],
    loop(N, Port, PidFizz, PidBuzz, PidFizzBuzz, PidNumber).

fizz(N) ->
    receive
        start ->
            fizz_loop(N)
    end.

buzz(N) ->
    receive
        start ->
            buzz_loop(N)
    end.

fizzbuzz(N) ->
    receive
        start ->
            fizzbuzz_loop(N)
    end.

number(N) ->
    receive
        start ->
            number_loop(N)
    end.

fizz_loop(N) ->
    receive
        {Value, Chan} ->
            if Value > N then
                Chan ! done,
                exit(normal)
            else
                if Value rem 3 == 0 andalso Value rem 5 /= 0 then
                    io:format("fizz~n", []),
                    Chan ! ok
                else
                    Chan ! skip
                end,
                fizz_loop(N)
            end
    end.

buzz_loop(N) ->
    receive
        {Value, Chan} ->
            if Value > N then
                Chan ! done,
                exit(normal)
            else
                if Value rem 3 /= 0 andalso Value rem 5 == 0 then
                    io:format("buzz~n", []),
                    Chan ! ok
                else
                    Chan ! skip
                end,
                buzz_loop(N)
            end
    end.

fizzbuzz_loop(N) ->
    receive
        {Value, Chan} ->
            if Value > N then
                Chan ! done,
                exit(normal)
            else
                if Value rem 3 == 0 andalso Value rem 5 == 0 then
                    io:format("fizzbuzz~n", []),
                    Chan ! ok
                else
                    Chan ! skip
                end,
                fizzbuzz_loop(N)
            end
    end.

number_loop(N) ->
    receive
        {Value, Chan} ->
            if Value > N then
                Chan ! done,
                exit(normal)
            else
                if Value rem 3 /= 0 andalso Value rem 5 /= 0 then
                    io:format("~w~n", [Value]),
                    Chan ! ok
                else
                    Chan ! skip
                end,
                number_loop(N)
            end
    end.

loop(N, Port, PidFizz, PidBuzz, PidFizzBuzz, PidNumber) ->
    loop(1, N, Port, PidFizz, PidBuzz, PidFizzBuzz, PidNumber).

loop(Value, N, Port, PidFizz, PidBuzz, PidFizzBuzz, PidNumber) ->
    if Value > N then
        Port ! {Value, Port},
        Port ! {Value, Port},
        Port ! {Value, Port},
        Port ! {Value, Port},
        receive
            done -> ok
        end,
        receive
            done -> ok
        end,
        receive
            done -> ok
        end,
        receive
            done -> ok
        end,
        ok
    else
        Port ! {Value, Port},
        Port ! {Value, Port},
        Port ! {Value, Port},
        Port ! {Value, Port},
        process_results(4, Value, N, Port, PidFizz, PidBuzz, PidFizzBuzz, PidNumber).
    end.

process_results(0, Value, N, Port, PidFizz, PidBuzz, PidFizzBuzz, PidNumber) ->
    loop(Value + 1, N, Port, PidFizz, PidBuzz, PidFizzBuzz, PidNumber);
process_results(Count, Value, N, Port, PidFizz, PidBuzz, PidFizzBuzz, PidNumber) ->
    receive
        ok -> process_results(Count - 1, Value, N, Port, PidFizz, PidBuzz, PidFizzBuzz, PidNumber);
        skip -> process_results(Count - 1, Value, N, Port, PidFizz, PidBuzz, PidFizzBuzz, PidNumber)
    end.