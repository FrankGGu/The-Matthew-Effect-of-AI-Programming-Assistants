-module(find_consecutive_integers).
-export([new/1, consec/2]).

new(Value) ->
    {0, Value, 0}.

consec({Count, Value, K}, Num) ->
    if
        Num =:= Value ->
            {Count + 1, Value, K};
        true ->
            {0, Value, K}
    end.

consec({Count, Value, K}, Count) ->
    Count >= Count.