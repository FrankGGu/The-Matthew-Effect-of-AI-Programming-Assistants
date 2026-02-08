-module(solution).
-export([find_destination/1]).

find_destination(Pairs) ->
    Outgoing = lists:foldl(fun({A, _}, Acc) -> sets:add_element(A, Acc) end, sets:new(), Pairs),
    lists:foldl(fun({_, B}, Acc) ->
        case sets:is_element(B, Outgoing) of
            true -> Acc;
            false -> B
        end
    end, "", Pairs).