-spec get_sum(A :: integer(), B :: integer()) -> integer().
get_sum(A, B) ->
    case B of
        0 -> A;
        _ -> get_sum(A bxor B, (A band B) bsl 1)
    end.