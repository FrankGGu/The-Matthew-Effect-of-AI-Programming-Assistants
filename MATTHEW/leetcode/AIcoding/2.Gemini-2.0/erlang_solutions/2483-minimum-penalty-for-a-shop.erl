-module(min_penalty).
-export([solve/1]).

solve(Customers) ->
    solve(Customers, length(Customers)).

solve(Customers, N) ->
    solve(Customers, N, 0, 0, 0).

solve([], N, CurrentPenalty, MinPenalty, _Index) ->
    min(MinPenalty, CurrentPenalty);
solve([Customer | Rest], N, CurrentPenalty, MinPenalty, Index) ->
    case Customer of
        'Y' ->
            NewPenalty = CurrentPenalty - 1;
        'N' ->
            NewPenalty = CurrentPenalty + 1
    end,
    NewMinPenalty = min(MinPenalty, NewPenalty),
    solve(Rest, N, NewPenalty, NewMinPenalty, Index + 1).