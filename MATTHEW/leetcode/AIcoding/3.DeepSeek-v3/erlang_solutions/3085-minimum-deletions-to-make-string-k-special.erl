-spec min_deletions(S :: unicode:unicode_binary(), K :: integer()) -> integer().
min_deletions(S, K) ->
    FreqMap = lists:foldl(fun(Char, Acc) -> 
                                maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                          end, #{}, unicode:characters_to_list(S)),
    Freqs = lists:sort(maps:values(FreqMap)),
    min_deletions_helper(Freqs, K, 0).

min_deletions_helper([], _, Deletions) -> Deletions;
min_deletions_helper([_], _, Deletions) -> Deletions;
min_deletions_helper([H | T], K, Deletions) ->
    case H =< lists:nth(1, T) - K of
        true ->
            NewDeletions = Deletions + H,
            min_deletions_helper(T, K, NewDeletions);
        false ->
            min_deletions_helper(T, K, Deletions)
    end.