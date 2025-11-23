-module(solution).
-export([minimalKSum/2]).

minimalKSum(Numbers, K) ->
    Sorted = lists:sort(Numbers),
    minimalKSum(Sorted, K, 1, 0, []).

minimalKSum(_, 0, _, Sum, _) -> Sum;
minimalKSum(Sorted, K, Current, Sum, Taken) ->
    case Sorted of
        [] -> 
            Sum + Current + (K - 1) * K div 2;
        [H | T] when H < Current -> 
            minimalKSum(T, K, Current + 1, Sum + Current, Taken ++ [Current]);
        _ when K > 0 ->
            minimalKSum(Sorted, K - 1, Current, Sum + Current, Taken ++ [Current]);
        _ -> 
            minimalKSum(Sorted, K, Current + 1, Sum, Taken)
    end.