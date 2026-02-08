-module(remove_beans).
-export([remove_beans/1]).

remove_beans(Beans) ->
    SortedBeans = lists:sort(Beans),
    N = length(SortedBeans),
    TotalSum = lists:sum(SortedBeans),

    remove_beans_helper(SortedBeans, N, TotalSum, 0, 0).

remove_beans_helper([], _N, _TotalSum, MinRemoved, _Index) ->
    MinRemoved;
remove_beans_helper([Bean|Rest], N, TotalSum, MinRemoved, Index) ->
    Removed = TotalSum - Bean * (N - Index),

    case Index == 0 of
        true ->
            remove_beans_helper(Rest, N, TotalSum, Removed, Index + 1);
        false ->
            NewMinRemoved = min(MinRemoved, Removed),
            remove_beans_helper(Rest, N, TotalSum, NewMinRemoved, Index + 1)
    end.