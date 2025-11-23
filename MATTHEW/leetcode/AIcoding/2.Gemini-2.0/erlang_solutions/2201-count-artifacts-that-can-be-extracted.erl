-module(solution).
-export([countArtifacts/3]).

countArtifacts(N, Dig, Artifacts) ->
    extractable_artifacts(Artifacts, create_dug_set(Dig)).

create_dug_set(Dig) ->
    lists:foldl(fun({X, Y}, Acc) -> sets:add({X, Y}, Acc) end, sets:new(), Dig).

extractable_artifacts(Artifacts, Dug) ->
    lists:foldl(fun(Artifact, Count) ->
                        case is_artifact_extractable(Artifact, Dug) of
                            true -> Count + 1;
                            false -> Count
                        end
                end, 0, Artifacts).

is_artifact_extractable([R1, C1, R2, C2], Dug) ->
    is_extractable(R1, C1, R2, C2, Dug).

is_extractable(R1, C1, R2, C2, Dug) ->
    lists:all(fun({R, C}) -> sets:is_element({R, C}, Dug) end, generate_coordinates(R1, C1, R2, C2)).

generate_coordinates(R1, C1, R2, C2) ->
    [ {R, C} || R <- lists:seq(R1, R2), C <- lists:seq(C1, C2) ].