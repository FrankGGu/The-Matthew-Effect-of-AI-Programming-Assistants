-module(solution).
-export([relocateMarbles/2]).

relocateMarbles(Marble, Moves) ->
    UniquePositions = lists:usort(Marble ++ Moves),
    lists:filter(fun(X) -> X > 0 end, UniquePositions).