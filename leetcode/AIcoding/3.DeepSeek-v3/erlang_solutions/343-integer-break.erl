-spec integer_break(N :: integer()) -> integer().
integer_break(N) when N =< 3 ->
    N - 1;
integer_break(N) ->
    case N rem 3 of
        0 -> trunc(math:pow(3, N div 3));
        1 -> trunc(math:pow(3, (N div 3) - 1)) * 4;
        2 -> trunc(math:pow(3, N div 3)) * 2
    end.