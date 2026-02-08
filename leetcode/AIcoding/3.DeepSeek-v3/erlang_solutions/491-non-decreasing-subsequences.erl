-spec find_subsequences(Nums :: [integer()]) -> [[integer()]].
find_subsequences(Nums) ->
    find_subsequences(Nums, [], []).

find_subsequences([], _, Acc) ->
    lists:usort(Acc);
find_subsequences([H | T], Current, Acc) ->
    NewAcc = case Current of
        [] -> [[H] | Acc];
        _ ->
            case lists:last(Current) =< H of
                true -> [[H | Current] | Acc];
                false -> Acc
            end
    end,
    NextAcc = find_subsequences(T, Current, NewAcc),
    find_subsequences(T, [H | Current], NextAcc).