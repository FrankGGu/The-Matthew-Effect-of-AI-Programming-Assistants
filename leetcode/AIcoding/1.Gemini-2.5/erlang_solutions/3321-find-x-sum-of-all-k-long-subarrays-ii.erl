-module(solution).
-export([find_x_sum/2]).

find_x_sum(Nums, K) ->
    case length(Nums) of
        Len when Len < K -> [];
        _ ->
            {InitialWindowElements, RestNums} = lists:split(K, Nums),
            InitialSum = lists:sum(InitialWindowElements),
            InitialQueue = lists:foldl(fun(E, Q) -> queue:in(E, Q) end, queue:new(), InitialWindowElements),
            slide_window(RestNums, InitialQueue, InitialSum, [InitialSum])
    end.

slide_window([], _CurrentQueue, _CurrentSum, AccResults) ->
    lists:reverse(AccResults);
slide_window([NewElement | RestNums], CurrentQueue, CurrentSum, AccResults) ->
    {value, OldestElement, QWithoutOldest} = queue:out(CurrentQueue),
    NewQueue = queue:in(NewElement, QWithoutOldest),
    NewSum = CurrentSum - OldestElement + NewElement,
    slide_window(RestNums, NewQueue, NewSum, [NewSum | AccResults]).