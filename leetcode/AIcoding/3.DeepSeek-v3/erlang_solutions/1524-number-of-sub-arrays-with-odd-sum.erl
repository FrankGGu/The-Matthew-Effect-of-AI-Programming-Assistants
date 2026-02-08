-spec num_of_subarrays(Arr :: [integer()]) -> integer().
num_of_subarrays(Arr) ->
    {Even, Odd, Sum} = lists:foldl(fun(N, {E, O, S}) ->
        NewS = (S + N) rem 2,
        case NewS of
            0 -> {E + 1, O, NewS};
            1 -> {E, O + 1, NewS}
        end
    end, {1, 0, 0}, Arr),
    (Even * Odd) rem 1000000007.