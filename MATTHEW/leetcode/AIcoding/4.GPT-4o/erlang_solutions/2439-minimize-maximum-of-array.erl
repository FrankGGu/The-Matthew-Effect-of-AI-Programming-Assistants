-module(solution).
-export([minimize_array/1]).

minimize_array(Array) ->
    Minimize = fun(Left, Right) ->
        if
            Left >= Right -> Left;
            true ->
                Mid = (Left + Right) div 2,
                if
                    can_reduce(Array, Mid) -> Minimize(Left, Mid);
                    true -> Minimize(Mid + 1, Right)
                end
        end
    end,
    Minimize(0, lists:max(Array)).

can_reduce(Array, Target) ->
    lists:foldl(fun(X, Acc) -> Acc + max(0, X - Target) end, 0, Array) =< Target.