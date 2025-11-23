-spec is_n_straight_hand(Hand :: [integer()], W :: integer()) -> boolean().
is_n_straight_hand(Hand, W) ->
    case length(Hand) rem W of
        0 ->
            Counts = lists:foldl(fun(Card, Acc) ->
                                    maps:update_with(Card, fun(V) -> V + 1 end, 1, Acc)
                                end, #{}, Hand),
            Sorted = lists:sort(maps:keys(Counts)),
            check_groups(Sorted, Counts, W);
        _ ->
            false
    end.

check_groups([], _, _) -> true;
check_groups([First | _] = Sorted, Counts, W) ->
    case maps:get(First, Counts, 0) of
        0 ->
            check_groups(tl(Sorted), Counts, W);
        Count ->
            case remove_group(First, Count, Counts, W) of
                {ok, NewCounts} ->
                    check_groups(Sorted, NewCounts, W);
                error ->
                    false
            end
    end.

remove_group(_, _, _, 0) -> {ok, #{}};
remove_group(Current, Count, Counts, W) ->
    case maps:get(Current, Counts, 0) of
        C when C >= Count ->
            NewCounts = maps:update(Current, C - Count, Counts),
            remove_group(Current + 1, Count, NewCounts, W - 1);
        _ ->
            error
    end.