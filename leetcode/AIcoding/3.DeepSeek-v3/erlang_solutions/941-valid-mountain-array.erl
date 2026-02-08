-spec valid_mountain_array(Arr :: [integer()]) -> boolean().
valid_mountain_array(Arr) ->
    N = length(Arr),
    if
        N < 3 -> false;
        true ->
            I = 1,
            {I1, _} = climb(Arr, I),
            if
                I1 == N -> false;
                I1 == 1 -> false;
                true ->
                    {I2, _} = descend(Arr, I1),
                    I2 == N
            end
    end.

climb(Arr, I) ->
    if
        I < length(Arr) andalso lists:nth(I + 1, Arr) > lists:nth(I, Arr) ->
            climb(Arr, I + 1);
        true ->
            {I, lists:nth(I, Arr)}
    end.

descend(Arr, I) ->
    if
        I < length(Arr) andalso lists:nth(I + 1, Arr) < lists:nth(I, Arr) ->
            descend(Arr, I + 1);
        true ->
            {I, lists:nth(I, Arr)}
    end.