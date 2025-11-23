-module(solution).
-export([destroy_targets/2]).

destroy_targets(Targets, Weight) ->
    lists:foldl(fun(Target, Acc) ->
        case Acc of
            [] -> [Target];
            [H | _] when H < Target -> Acc ++ [Target];
            [H | T] when H =< Target -> T ++ [Target]
        end
    end, [], Targets).