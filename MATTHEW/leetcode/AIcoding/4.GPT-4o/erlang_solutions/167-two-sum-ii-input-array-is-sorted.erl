-spec two_sum(Numbers :: [integer()], Target :: integer()) -> [integer()].
two_sum(Numbers, Target) ->
    two_sum(Numbers, Target, 1, length(Numbers)).

two_sum([H | T], Target, Left, Right) when Left < Right ->
    case (H + lists:nth(Right, [H | T])) of
        Target -> [Left, Right];
        _ -> two_sum(T, Target, Left + 1, Right - 1)
    end.
