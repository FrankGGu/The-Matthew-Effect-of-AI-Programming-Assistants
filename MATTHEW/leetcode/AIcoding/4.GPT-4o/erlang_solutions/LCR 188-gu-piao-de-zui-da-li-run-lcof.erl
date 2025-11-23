-module(solution).
-export([minCost/1]).

minCost(Chips) ->
    {Odd, Even} = lists:foldl(fun(X, {OddAcc, EvenAcc}) ->
        case X rem 2 of
            0 -> {OddAcc, EvenAcc + 1};
            _ -> {OddAcc + 1, EvenAcc}
        end
    end, {0, 0}, Chips),
    min(Odd, Even).

min(A, B) -> 
    if 
        A < B -> A; 
        true -> B 
    end.