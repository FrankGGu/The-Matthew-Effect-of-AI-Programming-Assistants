-module(frequency_most_frequent_element).
-export([max_frequency/1]).

max_frequency(Nums) ->
    SortedNums = lists:sort(Nums),
    max_frequency_helper(SortedNums, 0, 0, 0, 0).

max_frequency_helper([], _Left, _Right, _Sum, MaxFreq) ->
    MaxFreq;
max_frequency_helper([H | T], Left, Right, Sum, MaxFreq) ->
    NewSum = Sum + H,
    case (H * (Right - Left + 1)) - NewSum of
        Diff when Diff > 0 ->
            max_frequency_helper(lists:sublist(T, 1, length(T) - 1), Left + 1, Right + 1, NewSum - lists:nth(Left + 1, lists:sort(lists:reverse(lists:reverse(lists:sort(Nums))))), max(MaxFreq, Right - Left + 1));
        _ ->
            NewMaxFreq = max(MaxFreq, Right - Left + 2),
            max_frequency_helper(T, Left, Right + 1, NewSum, NewMaxFreq)
    end.