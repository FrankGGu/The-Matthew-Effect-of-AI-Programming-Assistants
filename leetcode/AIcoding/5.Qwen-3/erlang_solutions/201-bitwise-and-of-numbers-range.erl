-module(bitwise_and_of_numbers_range).
-export([range_bitwise_and/2]).

range_bitwise_and(M, N) ->
    Result = 0,
    shift = 0,
    loop(M, N, Result, shift).

loop(M, N, Result, Shift) when M =< N ->
    case (M band (1 bsl Shift)) of
        0 -> loop(M + 1, N, Result, Shift);
        _ -> loop(M + 1, N, Result bor (1 bsl Shift), Shift)
    end;
loop(_, _, Result, _) ->
    Result.