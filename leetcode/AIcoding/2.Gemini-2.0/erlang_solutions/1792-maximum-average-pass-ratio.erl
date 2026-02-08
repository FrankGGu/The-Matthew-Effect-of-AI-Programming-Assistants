-module(maximum_average_pass_ratio).
-export([max_average_ratio/2]).

max_average_ratio(Passes, ExtraStudents) ->
    PQ = priority_queue:new(),
    lists:foreach(fun([Pass, Total]) ->
        priority_queue:insert(neg_diff(Pass, Total), {Pass, Total}, PQ)
    end, Passes),

    lists:foldl(fun(_, Acc) ->
        {NegDiff, {Pass, Total}} = priority_queue:delete_max(Acc),
        NewPass = Pass + 1,
        NewTotal = Total + 1,
        priority_queue:insert(neg_diff(NewPass, NewTotal), {NewPass, NewTotal}, priority_queue:delete_max(Acc)),
        priority_queue:delete_max(Acc)
    end, PQ, lists:seq(1, ExtraStudents)),

    Sum = lists:foldl(fun(_, Acc) ->
        {_, {Pass, Total}} = priority_queue:delete_max(PQ),
        PQ = priority_queue:delete_max(PQ),
        Acc + (Pass / Total)
    end, 0, lists:seq(1, length(Passes))),
    Sum / length(Passes).

neg_diff(Pass, Total) ->
    - ((Pass + 1) / (Total + 1) - Pass / Total).