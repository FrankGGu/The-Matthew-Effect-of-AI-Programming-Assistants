-spec two_sum(Numbers :: [integer()], Target :: integer()) -> [integer()].
two_sum(Numbers, Target) ->
    two_sum(Numbers, Target, 1, length(Numbers)).

two_sum(Numbers, Target, Left, Right) when Left < Right ->
    Sum = lists:nth(Left, Numbers) + lists:nth(Right, Numbers),
    if
        Sum == Target -> [Left, Right];
        Sum < Target -> two_sum(Numbers, Target, Left + 1, Right);
        Sum > Target -> two_sum(Numbers, Target, Left, Right - 1)
    end.