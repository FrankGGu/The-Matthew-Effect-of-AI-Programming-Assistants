-module(solution).
-export([makesquare/1]).

makesquare(Matchsticks) ->
    Sum = lists:sum(Matchsticks),
    if
        Sum rem 4 =/= 0 ->
            false;
        true ->
            Side = Sum div 4,
            SortedMatchsticks = lists:sort(fun(A, B) -> A >= B end, Matchsticks),
            case SortedMatchsticks of
                [H|_] when H > Side -> false;
                _ -> solve(SortedMatchsticks, [0, 0, 0, 0], Side)
            end
    end.

solve([], _Sides, _TargetSide) ->
    true;
solve([M | Rest], Sides, TargetSide) ->
    lists:any(fun(Idx) ->
        CurrentSideLength = lists:nth(Idx, Sides),
        if
            CurrentSideLength + M =< TargetSide ->
                NewSides = lists:replace_nth(Idx, CurrentSideLength + M, Sides),
                solve(Rest, NewSides, TargetSide);
            true ->
                false
        end
    end, [1, 2, 3, 4]).