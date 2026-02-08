-spec min_swaps(Grid :: [[integer()]]) -> integer().
min_swaps(Grid) ->
    N = length(Grid),
    TrailingZeros = lists:map(fun(Row) ->
        lists:foldr(fun(X, Acc) ->
            case X of
                0 -> Acc + 1;
                _ -> Acc
            end
        end, 0, Row)
    end, Grid),
    Result = 0,
    min_swaps_helper(TrailingZeros, N, 0, Result).

min_swaps_helper(TrailingZeros, N, I, Result) when I >= N - 1 ->
    Result;
min_swaps_helper(TrailingZeros, N, I, Result) ->
    Needed = N - I - 1,
    case find_row(TrailingZeros, I, Needed) of
        -1 ->
            -1;
        K ->
            NewTrailingZeros = swap_rows(TrailingZeros, I, K),
            NewResult = Result + (K - I),
            min_swaps_helper(NewTrailingZeros, N, I + 1, NewResult)
    end.

find_row(TrailingZeros, Start, Needed) ->
    find_row(TrailingZeros, Start, Needed, Start).

find_row(TrailingZeros, Start, Needed, K) when K >= length(TrailingZeros) ->
    -1;
find_row(TrailingZeros, Start, Needed, K) ->
    case lists:nth(K + 1, TrailingZeros) >= Needed of
        true -> K;
        false -> find_row(TrailingZeros, Start, Needed, K + 1)
    end.

swap_rows(TrailingZeros, I, K) ->
    Row = lists:nth(K + 1, TrailingZeros),
    Prefix = lists:sublist(TrailingZeros, I),
    Middle = lists:sublist(TrailingZeros, I + 1, K - I),
    Suffix = lists:nthtail(K + 1, TrailingZeros),
    lists:append([Prefix, [Row], Middle, Suffix]).