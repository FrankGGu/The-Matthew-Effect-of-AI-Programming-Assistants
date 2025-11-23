-module(relocate_marbles).
-export([relocate_marbles/2]).

relocate_marbles(Marbles, MoveFrom) ->
    lists:usort(lists:foldl(fun(From, Acc) ->
        case lists:keymember(From, 1, Acc) of
            true -> lists:keydelete(From, 1, Acc);
            false -> Acc
        end
    end, Marbles, MoveFrom)).