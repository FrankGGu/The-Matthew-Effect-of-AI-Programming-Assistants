-spec count_symmetric_integers(Low :: integer(), High :: integer()) -> integer().
count_symmetric_integers(Low, High) ->
    lists:foldl(
        fun(N, Acc) ->
            case is_symmetric(N) of
                true -> Acc + 1;
                false -> Acc
            end
        end,
        0,
        lists:seq(Low, High)
    ).

is_symmetric(N) when N < 10 -> false;
is_symmetric(N) ->
    Digits = integer_to_list(N),
    case length(Digits) rem 2 of
        0 ->
            {FirstHalf, SecondHalf} = lists:split(length(Digits) div 2, Digits),
            lists:sum([C - $0 || C <- FirstHalf]) =:= lists:sum([C - $0 || C <- SecondHalf]);
        1 -> false
    end.