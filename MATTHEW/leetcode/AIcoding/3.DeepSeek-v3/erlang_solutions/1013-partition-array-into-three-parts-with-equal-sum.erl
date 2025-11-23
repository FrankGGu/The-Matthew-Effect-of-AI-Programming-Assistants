-spec can_three_parts_equal_sum(A :: [integer()]) -> boolean().
can_three_parts_equal_sum(A) ->
    TotalSum = lists:sum(A),
    case TotalSum rem 3 of
        0 ->
            Target = TotalSum div 3,
            can_partition(A, Target, 0, 0);
        _ ->
            false
    end.

can_partition([], _, Parts, _) ->
    Parts >= 3;
can_partition([H | T], Target, Parts, CurrentSum) ->
    NewSum = CurrentSum + H,
    if
        NewSum =:= Target ->
            can_partition(T, Target, Parts + 1, 0);
        true ->
            can_partition(T, Target, Parts, NewSum)
    end.