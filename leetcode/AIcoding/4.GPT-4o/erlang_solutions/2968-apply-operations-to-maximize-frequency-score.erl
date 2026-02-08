-module(solution).
-export([max_frequency_score/1]).

max_frequency_score(List) ->
    SortedList = lists:sort(List),
    {Max, Count} = lists:foldl(fun(X, {MaxAcc, CountAcc}) ->
        case X == MaxAcc of
            true -> {MaxAcc, CountAcc + 1};
            false -> {X, 1}
        end
    end, {hd(SortedList), 1}, SortedList),
    Count * Max.