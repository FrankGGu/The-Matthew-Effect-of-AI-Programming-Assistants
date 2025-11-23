-module(most_profit_assigning_work).
-export([max_profit_assigning_work/3]).

max_profit_assigning_work(Difficulty, Profit, Worker) ->
    Jobs = lists:zip(Difficulty, Profit),
    SortedJobs = lists:sort(fun({D1, _P1}, {D2, _P2}) -> D1 =< D2 end, Jobs),
    SortedWorker = lists:sort(Worker),
    max_profit_assigning_work_helper(SortedJobs, SortedWorker, 0, 0, 0).

max_profit_assigning_work_helper([], _, _CurrentProfit, _Index, Acc) ->
    Acc;
max_profit_assigning_work_helper(_, [], _CurrentProfit, _Index, Acc) ->
    Acc;
max_profit_assigning_work_helper(Jobs, [W | RestWorker], CurrentProfit, Index, Acc) ->
    {NewProfit, NewIndex} = find_max_profit(Jobs, W, CurrentProfit, Index),
    max_profit_assigning_work_helper(Jobs, RestWorker, NewProfit, NewIndex, Acc + NewProfit).

find_max_profit(Jobs, Worker, CurrentProfit, Index) ->
    find_max_profit_helper(Jobs, Worker, CurrentProfit, Index, 0, 0).

find_max_profit_helper([], _Worker, CurrentProfit, Index, MaxProfit, MaxIndex) ->
    {CurrentProfit, Index};
find_max_profit_helper([{Difficulty, Profit} | RestJobs], Worker, CurrentProfit, Index, MaxProfit, MaxIndex) ->
    if
        Difficulty =< Worker ->
            if
                Profit > CurrentProfit ->
                    find_max_profit_helper(RestJobs, Worker, Profit, Index + 1, Profit, Index + 1);
                true ->
                     find_max_profit_helper(RestJobs, Worker, CurrentProfit, Index + 1, MaxProfit, MaxIndex)
            end;
        true ->
            {CurrentProfit, Index}
    end.