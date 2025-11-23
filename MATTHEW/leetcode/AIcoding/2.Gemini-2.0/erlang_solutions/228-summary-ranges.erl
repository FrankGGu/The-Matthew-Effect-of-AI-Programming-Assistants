-module(summary_ranges).
-export([summaryRanges/1]).

summaryRanges(Nums) ->
    summaryRanges(Nums, []).

summaryRanges([], Acc) ->
    lists:reverse(Acc);
summaryRanges([H | T], Acc) ->
    summaryRanges(T, H, H, Acc).

summaryRanges([], Start, End, Acc) ->
    Range = formatRange(Start, End),
    lists:reverse([Range | Acc]);
summaryRanges([H | T], Start, End, Acc) ->
    case H == End + 1 of
        true ->
            summaryRanges(T, Start, H, Acc);
        false ->
            Range = formatRange(Start, End),
            summaryRanges(T, H, H, [Range | Acc])
    end.

formatRange(Start, End) ->
    case Start == End of
        true ->
            integer_to_list(Start);
        false ->
            integer_to_list(Start) ++ "->" ++ integer_to_list(End)
    end.