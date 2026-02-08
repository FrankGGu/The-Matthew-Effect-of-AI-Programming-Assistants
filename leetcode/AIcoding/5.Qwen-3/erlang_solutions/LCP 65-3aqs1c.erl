-module(humidity).
-export([humidity/1]).

humidity(S) ->
    {ok, [H]} = io_lib:parse_float(S),
    case H of
        H when H >= 40.0, H =< 60.0 -> true;
        _ -> false
    end.