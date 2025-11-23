-spec min_operations(Nums :: [integer()], K :: integer()) -> integer().
min_operations(Nums, K) ->
    min_operations(Nums, K, sets:new(), 0, 0).

min_operations([], _K, Set, _Count, Steps) ->
    Steps;
min_operations([Num | Rest], K, Set, Count, Steps) ->
    NewSteps = Steps + 1,
    if
        Num =< K ->
            case sets:is_element(Num, Set) of
                false ->
                    NewSet = sets:add_element(Num, Set),
                    NewCount = Count + 1,
                    if
                        NewCount =:= K ->
                            NewSteps;
                        true ->
                            min_operations(Rest, K, NewSet, NewCount, NewSteps)
                    end;
                true ->
                    min_operations(Rest, K, Set, Count, NewSteps)
            end;
        true ->
            min_operations(Rest, K, Set, Count, NewSteps)
    end.