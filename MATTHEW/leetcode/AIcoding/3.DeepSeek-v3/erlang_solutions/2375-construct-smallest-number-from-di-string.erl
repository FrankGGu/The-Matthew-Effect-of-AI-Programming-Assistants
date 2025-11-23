-spec smallest_number(Pattern :: unicode:unicode_binary()) -> unicode:unicode_binary().
smallest_number(Pattern) ->
    N = byte_size(Pattern) + 1,
    Stack = [],
    Result = [],
    {FinalStack, FinalResult} = process_pattern(Pattern, 0, Stack, Result, N),
    lists:concat([FinalResult | lists:reverse([I + $0 || I <- FinalStack])]).

process_pattern(<<>>, Current, Stack, Result, _N) ->
    {[Current | Stack], Result};
process_pattern(<<$D, Rest/binary>>, Current, Stack, Result, N) ->
    process_pattern(Rest, Current + 1, [Current | Stack], Result, N);
process_pattern(<<$I, Rest/binary>>, Current, Stack, Result, N) ->
    NewStack = [Current | Stack],
    NewResult = Result ++ [I + $0 || I <- lists:reverse(NewStack)],
    process_pattern(Rest, Current + 1, [], NewResult, N).