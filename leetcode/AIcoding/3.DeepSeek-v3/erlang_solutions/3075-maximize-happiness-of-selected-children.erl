-spec maximum_happiness_sum(Happiness :: [integer()], K :: integer()) -> integer().
maximum_happiness_sum(Happiness, K) ->
    Sorted = lists:sort(fun(A, B) -> A > B end, Happiness),
    Sum = lists:foldl(fun(X, {Acc, I}) ->
                          Val = max(X - I, 0),
                          {Acc + Val, I + 1}
                      end, {0, 0}, lists:sublist(Sorted, K)),
    element(1, Sum).