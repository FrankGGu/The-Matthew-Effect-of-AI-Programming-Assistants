-spec get_sum(A :: integer(), B :: integer()) -> integer().
get_sum(A, B) ->
    %% Use bitwise operations to simulate addition without using + or -
    sum(A, B).

sum(A, B) ->
    case B of
        0 -> A;
        _ -> sum(A bxor B, (A band B) bsl 1)
    end.
