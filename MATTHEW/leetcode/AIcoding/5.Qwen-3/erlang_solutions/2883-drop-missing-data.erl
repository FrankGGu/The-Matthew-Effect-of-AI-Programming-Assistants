-module(solution).
-export([drop_missing_data/1]).

drop_missing_data(Data) ->
    lists:filter(fun(Row) -> 
        case Row of
            [Name, _Age, _Country] when is_binary(Name) -> true;
            _ -> false
        end
    end, Data).