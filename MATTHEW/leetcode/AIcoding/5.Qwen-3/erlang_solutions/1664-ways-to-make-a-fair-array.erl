-module(ways_to_make_a_fair).
-export([num_schemes/2]).

num_schemes(Prices, Target) ->
    num_schemes(Prices, Target, 0, 0, 0).

num_schemes([], _, _, _, Count) ->
    Count;
num_schemes([Price | Rest], Target, Index, CurrentSum, Count) ->
    NewCurrentSum = CurrentSum + Price,
    if
        NewCurrentSum > Target ->
            num_schemes(Rest, Target, Index + 1, 0, Count);
        true ->
            NewCount = if
                Index == 0 ->
                    Count + 1;
                true ->
                    LeftSum = lists:sum(lists:sublist(Prices, Index)),
                    RightSum = lists:sum(lists:sublist(Prices, Index + 1, length(Prices) - Index - 1)),
                    if
                        (LeftSum + Price) == RightSum ->
                            Count + 1;
                        true ->
                            Count
                    end
            end,
            num_schemes(Rest, Target, Index + 1, 0, NewCount)
    end.