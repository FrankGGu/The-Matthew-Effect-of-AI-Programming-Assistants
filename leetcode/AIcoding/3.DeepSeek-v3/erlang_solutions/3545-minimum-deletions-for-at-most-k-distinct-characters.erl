-spec min_deletions(S :: unicode:unicode_binary(), K :: integer()) -> integer().
min_deletions(S, K) ->
    case K >= byte_size(S) of
        true -> 0;
        false ->
            Freq = lists:foldl(fun(Char, Acc) ->
                maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
            end, #{}, unicode:characters_to_list(S)),
            Sorted = lists:sort(fun(A, B) -> A > B end, maps:values(Freq)),
            min_deletions_helper(Sorted, K, 0)
    end.

min_deletions_helper([], _, Acc) -> Acc;
min_deletions_helper([H|T], K, Acc) ->
    case K > 0 of
        true -> min_deletions_helper(T, K - 1, Acc);
        false -> min_deletions_helper(T, K, Acc + H)
    end.