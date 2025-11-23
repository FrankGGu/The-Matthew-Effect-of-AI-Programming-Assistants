-spec find_closest(Seats :: [integer()]) -> integer().
find_closest(Seats) ->
    find_closest(Seats, 0, -1, -1, length(Seats)).

find_closest([], _Index, Left, Right, _Len) ->
    case {Left, Right} of
        {-1, -1} -> 0;
        {-1, R} -> R;
        {L, -1} -> (Len - 1) - L;
        {L, R} -> min((Len - 1) - L, R)
    end;
find_closest([1 | Rest], Index, Left, Right, Len) ->
    find_closest(Rest, Index + 1, Index, -1, Len);
find_closest([0 | Rest], Index, Left, Right, Len) ->
    case Right of
        -1 -> find_closest(Rest, Index + 1, Left, Right, Len);
        _ -> find_closest(Rest, Index + 1, Left, Right, Len)
    end.