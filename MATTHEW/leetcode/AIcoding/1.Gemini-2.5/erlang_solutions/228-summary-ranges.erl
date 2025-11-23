-module(solution).
-export([summaryRanges/1]).

summaryRanges(Nums) ->
    case Nums of
        [] -> [];
        _ -> process_ranges(Nums, [])
    end.

process_ranges([], Acc) ->
    lists:reverse(Acc);
process_ranges([H | T], Acc) ->
    {RangeEnd, RestOfList} = find_consecutive_end(H, T),
    RangeString = format_range(H, RangeEnd),
    process_ranges(RestOfList, [RangeString | Acc]).

find_consecutive_end(CurrentNum, []) ->
    {CurrentNum, []};
find_consecutive_end(CurrentNum, [NextNum | T]) when NextNum == CurrentNum + 1 ->
    find_consecutive_end(CurrentNum + 1, T);
find_consecutive_end(CurrentNum, List) ->
    {CurrentNum, List}.

format_range(Start, End) when Start == End ->
    integer_to_list(Start);
format_range(Start, End) ->
    io_lib:format("~w->~w", [Start, End]).