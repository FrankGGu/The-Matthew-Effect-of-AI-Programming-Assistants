-module(solution).
-export([min_set_size/1]).

min_set_size(Arr) ->
    N = length(Arr),
    Target = N div 2,

    FreqMap = lists:foldl(
        fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end,
        #{},
        Arr
    ),

    SortedFrequencies = lists:sort(fun(A, B) -> A >= B end, maps:values(FreqMap)),

    reduce(SortedFrequencies, Target, 0, 0).

reduce([], _Target, _CurrentSum, Count) ->
    Count;
reduce([H|T], Target, CurrentSum, Count) ->
    NewSum = CurrentSum + H,
    NewCount = Count + 1,
    if
        NewSum >= Target ->
            NewCount;
        true ->
            reduce(T, Target, NewSum, NewCount)
    end.