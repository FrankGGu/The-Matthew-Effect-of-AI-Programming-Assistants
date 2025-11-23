-module(minimize_xor).
-export([minimize_xor/2]).

minimize_xor(A, B) ->
    N = erlang:bit_size(A),
    {X, _} = lists:foldl(fun(I, {Acc, Bit}) ->
        Case = (A band (1 bsl (N - I - 1))) == 0,
        if
            Case ->
                if
                    (B band (1 bsl (N - I - 1))) == 0 ->
                        {Acc, Bit};
                    true ->
                        {Acc bor (1 bsl (N - I - 1)), Bit}
                end;
            true ->
                if
                    (B band (1 bsl (N - I - 1))) == 0 ->
                        {Acc bor (1 bsl (N - I - 1)), Bit};
                    true ->
                        {Acc, Bit}
                end
        end
    end, {0, 0}, lists:seq(0, N-1)),
    X bxor A.