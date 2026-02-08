-spec h_index(Citations :: [integer()]) -> integer().
h_index(Citations) ->
    N = length(Citations),
    h_index(Citations, 0, N - 1, N).

h_index(Citations, Left, Right, N) ->
    if
        Left > Right -> N - (Right + 1);
        true ->
            Mid = (Left + Right) div 2,
            H = N - Mid,
            case lists:nth(Mid + 1, Citations) >= H of
                true -> h_index(Citations, Left, Mid - 1, N);
                false -> h_index(Citations, Mid + 1, Right, N)
            end
    end.