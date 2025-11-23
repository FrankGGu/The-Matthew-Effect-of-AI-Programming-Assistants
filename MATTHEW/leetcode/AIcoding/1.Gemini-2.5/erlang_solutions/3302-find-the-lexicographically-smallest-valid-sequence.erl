-module(solution).
-export([solve/1]).

solve(N) ->
    Len = 2 * N,
    InitialSequence = array:new([{size, Len}, {default, 0}]),
    InitialUsed = array:new([{size, N + 1}, {default, false}]),
    InitialFirstPos = array:new([{size, N + 1}, {default, -1}]),

    backtrack(0, InitialSequence, InitialUsed, InitialFirstPos, N, Len).

backtrack(Index, Sequence, Used, FirstPos, N, Len) when Index == Len ->
    array:to_list(Sequence);

backtrack(Index, Sequence, Used, FirstPos, N, Len) ->
    CurrentVal = array:get(Index, Sequence),

    if CurrentVal =/= 0 ->
        backtrack(Index + 1, Sequence, Used, FirstPos, N, Len);
    true ->
        try_numbers(1, Index, Sequence, Used, FirstPos, N, Len)
    end.

try_numbers(I, Index, Sequence, Used, FirstPos, N, Len) when I > N ->
    [];

try_numbers(I, Index, Sequence, Used, FirstPos, N, Len) ->
    case array:get(I, Used) of
        true ->
            try_numbers(I + 1, Index, Sequence, Used, FirstPos, N, Len);
        false ->
            FirstIdxOfI = array:get(I, FirstPos),

            if FirstIdxOfI =/= -1 ->
                if Index - FirstIdxOfI == I ->
                    NewSequence = array:set(Index, I, Sequence),
                    NewUsed = array:set(I, true, Used),

                    Result = backtrack(Index + 1, NewSequence, NewUsed, FirstPos, N, Len),
                    if Result =/= [] -> Result;
                    true ->
                        try_numbers(I + 1, Index, Sequence, Used, FirstPos, N, Len)
                    end;
                true ->
                    try_numbers(I + 1, Index, Sequence, Used, FirstPos, N, Len)
                end;
            true ->
                SecondIdx = Index + I,
                if SecondIdx < Len andalso array:get(SecondIdx, Sequence) == 0 ->
                    NewSequence1 = array:set(Index, I, Sequence),
                    NewSequence2 = array:set(SecondIdx, I, NewSequence1),
                    NewFirstPos = array:set(I, Index, FirstPos),
                    NewUsed = array:set(I, true, Used),

                    Result = backtrack(Index + 1, NewSequence2, NewUsed, NewFirstPos, N, Len),
                    if Result =/= [] -> Result;
                    true ->
                        try_numbers(I + 1, Index, Sequence, Used, FirstPos, N, Len)
                    end;
                true ->
                    try_numbers(I + 1, Index, Sequence, Used, FirstPos, N, Len)
                end
            end
    end.