-module(solution).
-export([can_be_sorted/1]).

popcount(0) -> 0;
popcount(N) when N > 0 ->
    popcount(N band (N - 1)) + 1.

can_be_sorted(Nums) ->
    ModifiedNums = process_segments(Nums, []),
    is_sorted(ModifiedNums).

process_segments([], Acc) ->
    lists:reverse(Acc);
process_segments([H | T], Acc) ->
    H_popcount = popcount(H),
    {Segment, Rest} = find_segment([H | T], H_popcount, []),
    SortedSegment = lists:sort(Segment),
    process_segments(Rest, lists:reverse(SortedSegment) ++ Acc).

find_segment([], _TargetPopcount, CurrentSegmentAcc) ->
    {lists:reverse(CurrentSegmentAcc), []};
find_segment([H | T], TargetPopcount, CurrentSegmentAcc) ->
    case popcount(H) of
        TargetPopcount ->
            find_segment(T, TargetPopcount, [H | CurrentSegmentAcc]);
        _ ->
            {lists:reverse(CurrentSegmentAcc), [H | T]}
    end.

is_sorted([]) -> true;
is_sorted([_]) -> true;
is_sorted([H1, H2 | T]) ->
    H1 =< H2 andalso is_sorted([H2 | T]).