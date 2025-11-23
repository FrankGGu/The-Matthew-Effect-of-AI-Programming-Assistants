-module(fill_missing_data).
-export([fill_missing_data/1]).

fill_missing_data(Data) ->
    fill_missing_data(Data, []).

fill_missing_data([], Acc) ->
    lists:reverse(Acc);
fill_missing_data([{Key, Value} | Rest], Acc) when is_binary(Value) ->
    fill_missing_data(Rest, [{Key, Value} | Acc]);
fill_missing_data([{Key, Value} | Rest], Acc) ->
    fill_missing_data(Rest, [{Key, null} | Acc]).