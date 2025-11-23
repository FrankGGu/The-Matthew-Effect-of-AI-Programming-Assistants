-spec longest_consecutive(Nums :: [integer()]) -> integer().
longest_consecutive(Nums) ->
    Set = sets:from_list(Nums),
    lists:foldl(fun(N, Max) ->
        case sets:is_element(N - 1, Set) of
            false ->
                Current = find_consecutive(N, Set, 1),
                max(Max, Current);
            true ->
                Max
        end
    end, 0, Nums).

find_consecutive(N, Set, Len) ->
    case sets:is_element(N + 1, Set) of
        true -> find_consecutive(N + 1, Set, Len + 1);
        false -> Len
    end.