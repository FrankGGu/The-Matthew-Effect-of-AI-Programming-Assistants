-spec special_array(Nums :: [integer()]) -> integer().
special_array(Nums) ->
    Sorted = lists:sort(fun(A, B) -> A >= B end, Nums),
    special_array(Sorted, 0).

special_array([], X) ->
    -1;
special_array([H | T], X) ->
    if
        H >= X + 1 ->
            special_array(T, X + 1);
        true ->
            if
                X + 1 > H ->
                    if
                        X =:= length([H | T]) ->
                            X;
                        true ->
                            special_array(T, X)
                    end;
                true ->
                    special_array(T, X)
            end
    end.