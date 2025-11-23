-module(finding_mk_average).

-export([mkaverage/3, addElement/2, calculateMKAverage/1]).

-record(state, {
    m :: integer(),
    k :: integer(),
    nums :: list(),
    sum :: integer(),
    count :: integer(),
    window :: list()
}).

mkaverage(M, K, Streams) ->
    State0 = #state{m = M, k = K, nums = [], sum = 0, count = 0, window = []},
    lists:foldl(
        fun(X, State) ->
            {NewState, _} = addElement(X, State),
            NewState
        end,
        State0,
        Streams
    ).

addElement(Num, State = #state{m = M, nums = Nums, sum = Sum, count = Count, window = Window, k = K}) ->
    NewNums = Nums ++ [Num],
    NewCount = Count + 1,
    NewState = State#state{nums = NewNums, count = NewCount},

    if NewCount < M then
        {NewState, -1}
    else
        ShortenedNums = lists:sublist(NewNums, NewCount - M + 1, M),
        SortedNums = lists:sort(ShortenedNums),
        TrimmedNums = lists:sublist(SortedNums, K + 1, M - 2 * K),
        NewSum = lists:sum(TrimmedNums),

        Average = case M - 2 * K of
            0 -> 0;
            _ -> NewSum div (M - 2 * K)
        end,

        {NewState, Average}
    end.

calculateMKAverage(State = #state{m = M, nums = Nums, k = K}) ->
    NewCount = length(Nums),
    if NewCount < M then
        -1
    else
        ShortenedNums = lists:sublist(Nums, NewCount - M + 1, M),
        SortedNums = lists:sort(ShortenedNums),
        TrimmedNums = lists:sublist(SortedNums, K + 1, M - 2 * K),
        NewSum = lists:sum(TrimmedNums),

        case M - 2 * K of
            0 -> 0;
            _ -> NewSum div (M - 2 * K)
        end
    end.