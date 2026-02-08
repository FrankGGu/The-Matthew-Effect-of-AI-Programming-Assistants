-module(solution).
-export([findMaximizedCapital/4]).

findMaximizedCapital(K, W, Profits, Capital) ->
    Projects = lists:zip(Capital, Profits),
    SortedProjectsByCapital = lists:sort(fun({C1,_}, {C2,_}) -> C1 =< C2 end, Projects),

    find_max_capital_helper(K, W, SortedProjectsByCapital, []).

find_max_capital_helper(0, CurrentCapital, _, _) ->
    CurrentCapital;
find_max_capital_helper(K, CurrentCapital, MinCapitalHeap, MaxProfitHeap) ->
    {UpdatedMinCapitalHeap, UpdatedMaxProfitHeap} =
        move_affordable_projects(CurrentCapital, MinCapitalHeap, MaxProfitHeap),

    case UpdatedMaxProfitHeap of
        [] ->
            CurrentCapital;
        [MostProfitable | RestOfMaxProfitHeap] ->
            NewCapital = CurrentCapital + MostProfitable,
            find_max_capital_helper(K - 1, NewCapital, UpdatedMinCapitalHeap, RestOfMaxProfitHeap)
    end.

move_affordable_projects(CurrentCapital, MinCapitalHeap, MaxProfitHeap) ->
    move_affordable_projects_loop(CurrentCapital, MinCapitalHeap, MaxProfitHeap).

move_affordable_projects_loop(CurrentCapital, [{C, P}|RestMinCapitalHeap], MaxProfitHeap) when C =< CurrentCapital ->
    NewMaxProfitHeap = lists:insert_sorted(fun(Pr1, Pr2) -> Pr1 >= Pr2 end, P, MaxProfitHeap),
    move_affordable_projects_loop(CurrentCapital, RestMinCapitalHeap, NewMaxProfitHeap);
move_affordable_projects_loop(_, MinCapitalHeap, MaxProfitHeap) ->
    {MinCapitalHeap, MaxProfitHeap}.