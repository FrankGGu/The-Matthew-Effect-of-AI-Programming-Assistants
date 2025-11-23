-module(solution).
-export([combinationSum/2]).

combinationSum(Candidates, Target) ->
    SortedCandidates = lists:sort(Candidates),
    dfs(SortedCandidates, Target, []).

dfs(_Candidates, 0, CurrentPath) ->
    [lists:reverse(CurrentPath)];
dfs(_Candidates, RemainingTarget, _CurrentPath) when RemainingTarget < 0 ->
    [];
dfs([], _RemainingTarget, _CurrentPath) ->
    [];
dfs([H|_]=Candidates, RemainingTarget, CurrentPath) when H > RemainingTarget ->
    [];
dfs([H|T]=Candidates, RemainingTarget, CurrentPath) ->
    ResultsWithH = dfs(Candidates, RemainingTarget - H, [H|CurrentPath]),
    ResultsWithoutH = dfs(T, RemainingTarget, CurrentPath),
    ResultsWithH ++ ResultsWithoutH.