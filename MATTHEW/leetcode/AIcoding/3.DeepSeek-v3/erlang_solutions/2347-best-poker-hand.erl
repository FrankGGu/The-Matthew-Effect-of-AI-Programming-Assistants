-spec best_hand(Ranks :: [integer()], Suits :: [char()]) -> atom().
best_hand(Ranks, Suits) ->
    case is_flush(Suits) of
        true -> 'Flush';
        false ->
            case count_ranks(Ranks) of
                {_, Count} when Count >= 3 -> 'Three of a Kind';
                {_, Count} when Count == 2 -> 'Pair';
                _ -> 'High Card'
            end
    end.

is_flush(Suits) ->
    lists:all(fun(S) -> S =:= hd(Suits) end, Suits).

count_ranks(Ranks) ->
    Counts = lists:foldl(fun(Rank, Acc) ->
        maps:update_with(Rank, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, Ranks),
    lists:max(maps:to_list(Counts)).