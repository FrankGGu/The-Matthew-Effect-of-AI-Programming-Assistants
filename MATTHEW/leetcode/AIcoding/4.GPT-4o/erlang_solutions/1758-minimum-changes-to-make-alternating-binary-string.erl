-module(solution).
-export([min_flips/1]).

min_flips(S) ->
    {C1, C2} = lists:foldl(fun(X, {C1, C2}) ->
        case {X rem 2, C1 rem 2} of
            {0, 0} -> {C1 + 1, C2};
            {1, 1} -> {C1, C2 + 1};
            _ -> {C1, C2}
        end
    end, {0, 0}, string:to_integer(S)),
    min(C1, C2).

min(A, B) -> 
    if 
        A < B -> A; 
        true -> B 
    end.