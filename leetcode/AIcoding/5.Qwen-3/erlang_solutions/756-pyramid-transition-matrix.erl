-module(pyramid_transition_matrix).
-export([pyramidTransition/2]).

pyramidTransition(Blocks, T) ->
    Map = maps:from_list([{lists:sublist(B, 2), lists:last(B)} || B <- Blocks]),
    pyramidTransition(1, length(T), T, Map, []).

pyramidTransition(Level, MaxLevel, T, Map, Acc) when Level == MaxLevel ->
    case lists:member(Acc, T) of
        true -> true;
        false -> false
    end;

pyramidTransition(Level, MaxLevel, T, Map, Acc) ->
    NextLevel = lists:foldl(fun(X, Acc2) -> 
        case maps:is_key(X, Map) of
            true -> 
                lists:append(Acc2, [maps:get(X, Map)]);
            false -> Acc2
        end
    end, [], Acc),
    lists:foldl(fun(Next, Acc2) ->
        pyramidTransition(Level + 1, MaxLevel, T, Map, [Next | Acc]) orelse Acc2
    end, false, NextLevel).