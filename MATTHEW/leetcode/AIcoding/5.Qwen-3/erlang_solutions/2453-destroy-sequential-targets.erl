-module(solution).
-export([destroy_targets/2]).

destroy_targets(Targets, Cost) ->
    destroy_targets(Targets, Cost, 0, 0).

destroy_targets([], _, _, Result) ->
    Result;
destroy_targets([H | T], Cost, Index, Result) ->
    case H of
        {Start, End} when Start =< Index andalso End >= Index ->
            destroy_targets(T, Cost, Index + 1, Result + Cost);
        _ ->
            destroy_targets(T, Cost, Index + 1, Result)
    end.