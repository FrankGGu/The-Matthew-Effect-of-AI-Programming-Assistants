-module(solution).
-export([count_artifacts/2]).

count_artifacts(Artifacts, Lanes) ->
    Count = 0,
    lists:foldl(fun(Artifact, Acc) ->
        [Start, End] = Artifact,
        case is_extractable(Start, End, Lanes) of
            true -> Acc + 1;
            false -> Acc
        end
    end, Count, Artifacts).

is_extractable(Start, End, Lanes) ->
    lists:all(fun(Lane) -> 
        (Lane >= Start) and (Lane =< End)
    end, Lanes).