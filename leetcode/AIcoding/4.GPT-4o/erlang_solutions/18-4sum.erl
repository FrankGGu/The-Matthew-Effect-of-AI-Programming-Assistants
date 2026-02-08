-spec four_sum(Nums :: [integer()], Target :: integer()) -> [[integer()]].
four_sum(Nums, Target) ->
    four_sum(lists:sort(Nums), Target, [], []).

four_sum([], _, Acc, _) -> lists:reverse(Acc);
four_sum([H | T], Target, Acc, Prev) ->
    four_sum_helper(T, Target, H, Acc, Prev, 1).

four_sum_helper([], _, _, Acc, _, _) -> Acc;
four_sum_helper([H | T], Target, First, Acc, Prev, Count) ->
    case Target - First - H of
        0 -> 
            case lists:member([First, H], Prev) of
                true -> four_sum_helper(T, Target, First, Acc, Prev, Count + 1);
                false -> four_sum_helper(T, Target, First, [[First, H] | Acc], [[First, H] | Prev], Count + 1)
            end;
        _ -> four_sum_helper(T, Target, First, Acc, Prev, Count + 1)
    end.
