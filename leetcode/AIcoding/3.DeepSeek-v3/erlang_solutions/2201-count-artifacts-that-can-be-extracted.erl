-spec dig_artifacts(N :: integer(), Artifacts :: [[integer()]], Dig :: [[integer()]]) -> integer().
dig_artifacts(N, Artifacts, Dig) ->
    DigSet = sets:from_list(Dig),
    lists:foldl(
        fun([r1, c1, r2, c2], Acc) ->
            case check_artifact(r1, c1, r2, c2, DigSet) of
                true -> Acc + 1;
                false -> Acc
            end
        end,
        0,
        Artifacts
    ).

check_artifact(R1, C1, R2, C2, DigSet) ->
    lists:all(
        fun({R, C}) -> sets:is_element([R, C], DigSet) end,
        [{R, C} || R <- lists:seq(R1, R2), C <- lists:seq(C1, C2)]
    ).