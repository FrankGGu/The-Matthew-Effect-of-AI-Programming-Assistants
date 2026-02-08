-spec longest_consecutive(Nums :: [integer()]) -> integer().
longest_consecutive(Nums) ->
    Set = sets:from_list(Nums),
    lists:foldl(fun(N, Max) ->
        case sets:is_element(N - 1, Set) of
            false ->
                Current = length_seq(N, Set, 0),
                max(Max, Current);
            true ->
                Max
        end
    end, 0, Nums).

length_seq(N, Set, Len) ->
    case sets:is_element(N, Set) of
        true -> length_seq(N + 1, Set, Len + 1);
        false -> Len
    end.