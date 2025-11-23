-module(solution).
-export([is_one_bit_character/1]).

is_one_bit_character(Chars) ->
    N = length(Chars),
    I = 0,
    loop(Chars, I, N).

loop(Chars, I, N) when I == N - 1 ->
    true;
loop(Chars, I, N) when I < N - 1 ->
    case lists:nth(I + 1, Chars) of
        1 ->
            loop(Chars, I + 2, N);
        _ ->
            loop(Chars, I + 1, N)
    end.