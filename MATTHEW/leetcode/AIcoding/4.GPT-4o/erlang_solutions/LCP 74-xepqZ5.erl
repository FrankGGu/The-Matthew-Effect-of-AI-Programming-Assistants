-module(solution).
-export([stronger_blessing_field/2]).

stronger_blessing_field(N, R) ->
    lists:foldl(fun(X, Acc) ->
        {sum, count} = Acc,
        Sum = sum + (X div R),
        Count = count + (X rem R),
        {Sum, Count}
    end, {0, 0}, lists:seq(1, N)).