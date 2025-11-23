-module(solution).
-export([melt/3]).

melt(Data, IdVars, ValueVars) ->
    [Headers | Rows] = Data,

    ActualValueVars = 
        case ValueVars of
            [] -> 
                lists:filter(fun(H) -> not lists:member(H, IdVars) end, Headers);
            _ -> 
                ValueVars
        end,

    NewHeaders = IdVars ++ [variable, value],

    MeltedRows = lists:flatmap(fun(Row) ->
        RowProplist = lists:zip(Headers, Row),

        IdValues = [proplists:get_value(IdVar, RowProplist) || IdVar <- IdVars],

        lists:map(fun(ValueVarName) ->
            Value = proplists:get_value(ValueVarName, RowProplist),
            IdValues ++ [ValueVarName, Value]
        end, ActualValueVars)
    end, Rows),

    [NewHeaders | MeltedRows].