-module(max_robots).
-export([maximum_robots/3]).

maximum_robots(Costs, RunningCosts, Budget) ->
    maximum_robots(Costs, RunningCosts, Budget, 0, 0, 0, 0).

maximum_robots([], _, _, Start, End, Max, _) ->
    max(Max, End - Start);
maximum_robots(Costs, RunningCosts, Budget, Start, End, Max, SumCost) ->
    case Costs of
        [Cost | RestCosts] ->
            NewSumCost = SumCost + Cost,
            NewEnd = End + 1,
            NewRunningCost = sum(lists:sublist(RunningCosts, Start + 1, NewEnd - Start)),
            TotalCost = NewSumCost + (NewEnd - Start) * min(lists:sublist(RunningCosts, Start + 1, NewEnd - Start)),
            case TotalCost =< Budget of
                true ->
                    maximum_robots(RestCosts, RunningCosts, Budget, Start, NewEnd, max(Max, NewEnd - Start), NewSumCost);
                false ->
                    maximum_robots(RestCosts, RunningCosts, Budget, Start + 1, NewEnd, Max, SumCost - lists:nth(Start+1, Costs));
                _ ->
                    0
            end;
        [] ->
            max(Max, End - Start)
    end.

sum(List) ->
    sum(List, 0).

sum([], Acc) ->
    Acc;
sum([H|T], Acc) ->
    sum(T, Acc+H).

min(List) ->
    min(List, hd(List)).

min([H|[]], Acc) ->
    min(H, Acc);
min([H|T], Acc) ->
    min(T, min(H, Acc)).

min([], Acc) ->
    Acc;
min([H|T], Acc) when H < Acc ->
    min(T, H);
min([_|T], Acc) ->
    min(T, Acc).