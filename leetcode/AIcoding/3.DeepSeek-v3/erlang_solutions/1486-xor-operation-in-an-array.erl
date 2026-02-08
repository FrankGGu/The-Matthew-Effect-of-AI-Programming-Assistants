-spec xor_operation(N :: integer(), Start :: integer()) -> integer().
xor_operation(N, Start) ->
    xor_operation(N, Start, 0, 0).

xor_operation(0, _, _, Result) ->
    Result;
xor_operation(N, Start, I, Result) ->
    Num = Start + 2 * I,
    xor_operation(N - 1, Start, I + 1, Result bxor Num).