-module(solution).
-export([change_data_type/1]).

change_data_type(Data) ->
    case Data of
        {ok, Value} -> Value;
        {error, Reason} -> {error, Reason};
        _ -> {error, unknown_type}
    end.