-module(triangle).
-export([minimum_total/1]).

minimum_total(Triangle) ->
    N = length(Triangle),
    case N of
        0 -> 0;
        1 -> hd(hd(Triangle));
        _ ->
            ReversedTriangle = lists:reverse(Triangle),
            LastRow = hd(ReversedTriangle),
            RemainingRowsReversed = tl(ReversedTriangle),

            FinalRow = lists:foldl(
                fun(CurrentUpperRow, AccLowerRow) ->
                    combine_rows(CurrentUpperRow, AccLowerRow)
                end,
                LastRow,
                RemainingRowsReversed
            ),
            hd(FinalRow)
    end.

combine_rows(UpperRow, LowerRow) ->
    combine_rows_list(UpperRow, LowerRow).

combine_rows_list([U|Us], [L1, L2|Ls]) ->
    [U + min(L1, L2) | combine_rows_list(Us, [L2|Ls])];
combine_rows_list([], [_]) ->
    [].