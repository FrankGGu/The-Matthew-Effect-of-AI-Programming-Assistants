-module(profitable_schemes).
-export([profitable_schemes/2]).

profitable_schemes(G, P) ->
    profitable_schemes(G, P, 0, 0, 0, 0, 0, 0, 0).

profitable_schemes(_, _, _, _, _, _, _, _, Count) when Count >= 1000000007 ->
    Count rem 1000000007;
profitable_schemes(G, P, Index, CurrentProfit, CurrentMembers, TotalProfit, TotalMembers, _Count, Count) when Index >= length(P) ->
    case CurrentProfit >= G of
        true -> Count + 1;
        false -> Count
    end;
profitable_schemes(G, P, Index, CurrentProfit, CurrentMembers, TotalProfit, TotalMembers, _Count, Count) ->
    Scheme = lists:nth(Index + 1, P),
    Profit = element(1, Scheme),
    Members = element(2, Scheme),
    NewCurrentProfit = CurrentProfit + Profit,
    NewCurrentMembers = CurrentMembers + Members,
    if
        NewCurrentMembers =< TotalMembers ->
            NewCount = profitable_schemes(G, P, Index + 1, NewCurrentProfit, NewCurrentMembers, TotalProfit, TotalMembers, 0, Count),
            profitable_schemes(G, P, Index + 1, CurrentProfit, CurrentMembers, TotalProfit, TotalMembers, 0, NewCount);
        true ->
            profitable_schemes(G, P, Index + 1, CurrentProfit, CurrentMembers, TotalProfit, TotalMembers, 0, Count)
    end.