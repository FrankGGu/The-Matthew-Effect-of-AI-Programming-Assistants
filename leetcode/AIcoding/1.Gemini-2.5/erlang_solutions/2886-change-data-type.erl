-module(solution).
-export([change_data_type/1]).

change_data_type(Value) when is_integer(Value) ->
    integer_to_list(Value);
change_data_type(Value) when is_list(Value) ->
    try list_to_integer(Value) of
        Int -> Int
    catch
        error:badarg -> Value
    end;
change_data_type(Value) ->
    Value.