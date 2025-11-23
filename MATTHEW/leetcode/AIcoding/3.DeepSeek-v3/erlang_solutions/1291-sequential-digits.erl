-spec sequential_digits(Low :: integer(), High :: integer()) -> [integer()].
sequential_digits(Low, High) ->
    All = lists:sort([ list_to_integer([$0 + I || I <- lists:seq(Start, Start + Len - 1)]) 
                      || Len <- lists:seq(2, 9), Start <- lists:seq(1, 10 - Len) ]),
    lists:filter(fun(X) -> X >= Low andalso X =< High end, All).