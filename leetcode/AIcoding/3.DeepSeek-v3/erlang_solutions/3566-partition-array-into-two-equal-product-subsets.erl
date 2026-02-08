-spec can_partition(Products :: [integer()]) -> boolean().
can_partition(Products) ->
    Total = lists:sum(Products),
    case Total rem 2 of
        1 -> false;
        0 -> 
            Half = Total div 2,
            can_partition(Products, Half)
    end.

can_partition([], 0) -> true;
can_partition([], _) -> false;
can_partition([H|T], Target) ->
    case H > Target of
        true -> can_partition(T, Target);
        false -> 
            can_partition(T, Target) orelse can_partition(T, Target - H)
    end.