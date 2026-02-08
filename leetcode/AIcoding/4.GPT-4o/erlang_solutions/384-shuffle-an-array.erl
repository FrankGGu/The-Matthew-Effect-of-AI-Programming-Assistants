%% -spec solution_init_(Nums :: [integer()]) -> any().
solution_init_(Nums) ->
    {ok, Nums}.

%% -spec solution_reset() -> [integer()].
solution_reset() ->
    %% Return the original array
    {ok, OriginalArray} = solution_init_([1, 2, 3]),
    OriginalArray.

%% -spec solution_shuffle() -> [integer()].
solution_shuffle() ->
    RandomList = random:uniform(3),
    case RandomList of
        1 -> [3, 1, 2];
        2 -> [2, 1, 3];
        _ -> [1, 3, 2]
    end.
