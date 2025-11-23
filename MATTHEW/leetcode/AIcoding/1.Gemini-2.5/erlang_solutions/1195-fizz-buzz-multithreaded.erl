-module(fizzbuzz).
-export([start/5, fizz/1, buzz/1, fizzbuzz/1, number/1]).

server_loop(N, CurrentNum, FizzFunc, BuzzFunc, FizzBuzzFunc, NumberFunc, WaitingQueue) ->
    if
        CurrentNum > N ->
            lists:foreach(fun({Pid, _}) -> Pid ! eof end, WaitingQueue),
            ok;
        true ->
            CorrectType =
                if
                    CurrentNum rem 15 == 0 -> fizzbuzz_call;
                    CurrentNum rem 3 == 0 -> fizz_call;
                    CurrentNum rem 5 == 0 -> buzz_call;
                    true -> number_call
                end,

            case find_and_remove(CorrectType, WaitingQueue, []) of
                {ok, {PidToDispatch, TypeToDispatch}, NewWaitingQueue} ->
                    dispatch_call(TypeToDispatch, PidToDispatch, CurrentNum, FizzFunc, BuzzFunc, FizzBuzzFunc, NumberFunc),
                    server_loop(N, CurrentNum + 1, FizzFunc, BuzzFunc, FizzBuzzFunc, NumberFunc, NewWaitingQueue);
                no_dispatch ->
                    receive
                        {CallerPid, Type} ->
                            server_loop(N, CurrentNum, FizzFunc, BuzzFunc, FizzBuzzFunc, NumberFunc, [{CallerPid, Type} | WaitingQueue]);
                        _ ->
                            server_loop(N, CurrentNum, FizzFunc, BuzzFunc, FizzBuzzFunc, NumberFunc, WaitingQueue)
                    end
            end
    end.

find_and_remove(TargetType, [{Pid, TargetType} | Rest], Acc) ->
    {ok, {Pid, TargetType}, lists:reverse(Acc) ++ Rest};
find_and_remove(TargetType, [H | T], Acc) ->
    find_and_remove(TargetType, T, [H | Acc]);
find_and_remove(_, [], _) ->
    no_dispatch.

dispatch_call(fizzbuzz_call, Pid, _Num, _FizzFunc, _BuzzFunc, FizzBuzzFunc, _NumberFunc) ->
    Pid ! ok,
    FizzBuzzFunc();
dispatch_call(fizz_call, Pid, _Num, FizzFunc, _BuzzFunc, _FizzBuzzFunc, _NumberFunc) ->
    Pid ! ok,
    FizzFunc();
dispatch_call(buzz_call, Pid, _Num, _FizzFunc, BuzzFunc, _FizzBuzzFunc, _NumberFunc) ->
    Pid ! ok,
    BuzzFunc();
dispatch_call(number_call, Pid, Num, _FizzFunc, _BuzzFunc, _FizzBuzzFunc, NumberFunc) ->
    Pid ! ok,
    NumberFunc(Num).

start(N, FizzFunc, BuzzFunc, FizzBuzzFunc, NumberFunc) ->
    spawn(?MODULE, server_loop, [N, 1, FizzFunc, BuzzFunc, FizzBuzzFunc, NumberFunc, []]).

call_server(ServerPid, Type) ->
    ServerPid ! {self(), Type},
    receive
        ok ->
            ok;
        eof ->
            exit(normal)
    end.

fizz(ServerPid) ->
    call_server(ServerPid, fizz_call).

buzz(ServerPid) ->
    call_server(ServerPid, buzz_call).

fizzbuzz(ServerPid) ->
    call_server(ServerPid, fizzbuzz_call).

number(ServerPid) ->
    call_server(ServerPid, number_call).