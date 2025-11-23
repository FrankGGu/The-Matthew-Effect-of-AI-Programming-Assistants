-module(valid_number).
-export([is_number/1]).

is_number(S) ->
    try
        case string:to_float(S) of
            {error, _} ->
                false;
            _ ->
                true
        end
    catch
        _:_ ->
            false
    end.