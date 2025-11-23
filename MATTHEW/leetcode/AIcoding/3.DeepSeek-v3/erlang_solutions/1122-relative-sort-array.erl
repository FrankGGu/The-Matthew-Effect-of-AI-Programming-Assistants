-spec relative_sort_array(Arr1 :: [integer()], Arr2 :: [integer()]) -> [integer()].
relative_sort_array(Arr1, Arr2) ->
    Map = maps:from_list([{X, I} || {I, X} <- lists:zip(lists:seq(0, length(Arr2) - 1), Arr2)]),
    F = fun(X) ->
        case maps:find(X, Map) of
            {ok, I} -> I;
            error -> 1000 + X
        end
    end,
    lists:sort(fun(A, B) -> F(A) =< F(B) end, Arr1).