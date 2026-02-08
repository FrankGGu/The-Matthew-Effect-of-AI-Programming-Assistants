-module(zero_even_odd).
-export([zero/2, even/2, odd/2]).

zero(N, Chan) ->
    for(1, N, 1, fun(I) ->
        receive
            {print_zero, Pid} ->
                Chan ! {self(), 0},
                Pid ! {ok, self()}
        end
    end).

even(N, Chan) ->
    for(1, N, 1, fun(I) ->
        receive
            {print_even, Pid} ->
                Chan ! {self(), 2 * I},
                Pid ! {ok, self()}
        end
    end).

odd(N, Chan) ->
    for(1, N, 1, fun(I) ->
        receive
            {print_odd, Pid} ->
                Chan ! {self(), 2 * I - 1},
                Pid ! {ok, self()}
        end
    end).

for(Start, End, Step, Fun) ->
    for(Start, End, Step, Fun, ok).

for(I, End, Step, Fun, Acc) when I > End ->
    Acc;
for(I, End, Step, Fun, Acc) ->
    Fun(I),
    for(I + Step, End, Step, Fun, Acc).