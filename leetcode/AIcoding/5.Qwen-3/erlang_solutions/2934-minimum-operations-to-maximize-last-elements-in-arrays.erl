-module(solution).
-export([min_operations/2]).

min_operations(A, B) ->
    min_operations(A, B, 0).

min_operations([], [], Acc) ->
    Acc;
min_operations([AHead | ATail], [BHead | BTail], Acc) ->
    if
        AHead >= BHead ->
            min_operations(ATail, BTail, Acc);
        true ->
            min_operations(ATail, BTail, Acc + (BHead - AHead))
    end.