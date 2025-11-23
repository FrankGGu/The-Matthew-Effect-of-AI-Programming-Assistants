-module(solution).
-export([count_artifacts/3]).

count_artifacts(_N, Artifacts, Dig) ->
    DigSet = gb_sets:from_list([ {R, C} || [R, C] <- Dig ]),

    lists:foldl(fun(Artifact, Acc) ->
        case is_artifact_fully_dug(Artifact, DigSet) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Artifacts).

is_artifact_fully_dug([R1, C1, R2, C2], DigSet) ->
    AllArtifactCells = [ {R, C} || R <- lists:seq(R1, R2), C <- lists:seq(C1, C2) ],
    lists:all(fun(Cell) -> gb_sets:is_element(Cell, DigSet) end, AllArtifactCells).