-module(maximum_erasure_value).
-export([maximum_unique_subarray/1]).

maximum_unique_subarray(Nums) ->
    maximum_unique_subarray(Nums, [], 0, 0, 0).

maximum_unique_subarray([], _, CurrentSum, MaxSum, _) ->
    max(CurrentSum, MaxSum);
maximum_unique_subarray([H|T], Seen, CurrentSum, MaxSum, Start) ->
    case lists:member(H, Seen) of
        true ->
            Index = lists:keyfind(H, 1, lists:zip(Seen, lists:seq(Start, length(Seen) + Start -1))),
            {H, IndexValue} = Index,
            NewStart = IndexValue + 1,
            NewSeen = lists:sublist(Seen, NewStart - Start + 1, length(Seen) - (NewStart - Start)),
            NewCurrentSum = lists:sum(lists:sublist(Seen, NewStart - Start + 1, length(Seen) - (NewStart - Start))),
            maximum_unique_subarray([H|T], NewSeen, NewCurrentSum, MaxSum, NewStart);
        false ->
            NewCurrentSum = CurrentSum + H,
            NewSeen = Seen ++ [H],
            maximum_unique_subarray(T, NewSeen, NewCurrentSum, max(NewCurrentSum,MaxSum), Start)
    end.