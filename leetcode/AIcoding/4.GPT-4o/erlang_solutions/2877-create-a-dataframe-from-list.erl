-module(data_frame).
-export([create_dataframe/1]).

create_dataframe(List) ->
    [{RowNumber, Row} || {RowNumber, Row} <- lists:zip(lists:seq(1, length(List)), List)].