-module(ipo).
-export([find_maximized_capital/3]).

find_maximized_capital(K, W, Profits, Capital) ->
    N = length(Profits),
    Projects = lists:zip(Capital, Profits),
    SortedProjects = lists:keysort(1, Projects),
    find_maximized_capital(K, W, SortedProjects, []).

find_maximized_capital(0, W, _SortedProjects, _AvailableProjects) ->
    W;
find_maximized_capital(K, W, SortedProjects, AvailableProjects) ->
    {NewAvailableProjects, RemainingProjects} = update_available_projects(W, SortedProjects, AvailableProjects),
    case NewAvailableProjects of
        [] ->
            W;
        _ ->
            {MaxProfit, Rest} = find_max_profit(NewAvailableProjects, []),
            find_maximized_capital(K - 1, W + MaxProfit, RemainingProjects, Rest)
    end.

update_available_projects(W, SortedProjects, AvailableProjects) ->
    update_available_projects(W, SortedProjects, AvailableProjects, [], []).

update_available_projects(W, [], AvailableProjects, NewAvailableProjects, RemainingProjects) ->
    {lists:reverse(NewAvailableProjects) ++ AvailableProjects, lists:reverse(RemainingProjects)};
update_available_projects(W, [{Capital, Profit} | Rest], AvailableProjects, NewAvailableProjects, RemainingProjects) ->
    case Capital =< W of
        true ->
            update_available_projects(W, Rest, AvailableProjects, [{Profit, Capital} | NewAvailableProjects], RemainingProjects);
        false ->
            update_available_projects(W, Rest, AvailableProjects, NewAvailableProjects, [{Capital, Profit} | RemainingProjects])
    end.

find_max_profit([{Profit, _Capital} | Rest], Acc) ->
    find_max_profit(Rest, [{Profit, _Capital} | Acc]);
find_max_profit([], Acc) ->
    find_max_profit_helper(Acc, 0, []).

find_max_profit_helper([], MaxProfit, Remaining) ->
    {MaxProfit, Remaining};
find_max_profit_helper([{Profit, Capital} | Rest], CurrentMax, Remaining) ->
    case Profit > CurrentMax of
        true ->
            find_max_profit_helper(Rest, Profit, [{CurrentMax, Capital} | Remaining]);
        false ->
            find_max_profit_helper(Rest, CurrentMax, [{Profit, Capital} | Remaining])
    end;
find_max_profit_helper([{Profit, _} | Rest], 0, []) ->
    find_max_profit_helper(Rest, Profit, []).