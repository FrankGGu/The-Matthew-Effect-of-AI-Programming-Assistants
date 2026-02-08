-spec cells_in_range(Str :: unicode:unicode_binary()) -> [unicode:unicode_binary()].
cells_in_range(Str) ->
    [C1, R1, $:, C2, R2] = unicode:characters_to_list(Str),
    lists:reverse(
        lists:foldl(
            fun(C, Acc) ->
                lists:foldl(
                    fun(R, InnerAcc) ->
                        [unicode:characters_to_binary([C, R]) | InnerAcc]
                    end,
                    Acc,
                    lists:seq(R1, R2)
                )
            end,
            [],
            lists:seq(C1, C2)
        )
    ).