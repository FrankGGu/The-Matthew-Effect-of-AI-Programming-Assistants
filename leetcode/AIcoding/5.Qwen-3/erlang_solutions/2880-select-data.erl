-module(solution).
-export([select_data/1]).

select_data(Data) ->
    case Data of
        [] -> [];
        [[Name, Age] | _] when is_integer(Age) -> [Name];
        _ -> []
    end.