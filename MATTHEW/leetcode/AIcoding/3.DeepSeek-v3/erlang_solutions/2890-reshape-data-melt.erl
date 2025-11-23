-spec melt(Data :: map(), IdVars :: [atom()], ValueVars :: [atom()], VarName :: atom(), ValueName :: atom()) -> [map()].
melt(Data, IdVars, ValueVars, VarName, ValueName) ->
    lists:foldl(
        fun(ValueVar, Acc) ->
            lists:foldl(
                fun(Row, InnerAcc) ->
                    IdPart = maps:with(IdVars, Row),
                    Value = maps:get(ValueVar, Row),
                    NewRow = IdPart#{VarName => ValueVar, ValueName => Value},
                    [NewRow | InnerAcc]
                end,
                Acc,
                Data
            )
        end,
        [],
        ValueVars
    ).