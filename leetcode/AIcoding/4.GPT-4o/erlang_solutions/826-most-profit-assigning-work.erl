-module(solution).
-export([mostProfitAssigningWork/2]).

mostProfitAssigningWork(JobDifficulty, Worker) ->
    MaxD = lists:max(JobDifficulty),
    N = length(JobDifficulty),
    M = length(Worker),
    DP = lists:duplicate(N + 1, lists:duplicate(M + 1, 0)),
    lists:foldl(fun(_, DP) ->
        lists:foldl(fun(WorkerLevel, DP) ->
            lists:foldl(fun(JobIndex, DP) ->
                MaxJobDifficulty = lists:max(lists:sublist(JobDifficulty, 1, JobIndex)),
                Profit = MaxJobDifficulty + lists:element(WorkerLevel, DP),
                NewDP = lists:update_element(JobIndex + 1, lists:update_element(WorkerLevel + 1, Profit, lists:element(JobIndex + 1, DP)), DP),
                NewDP
            end, DP, lists:seq(0, JobIndex - 1))
        end, DP, lists:seq(0, M - 1))
    end, DP, lists:seq(1, N)).