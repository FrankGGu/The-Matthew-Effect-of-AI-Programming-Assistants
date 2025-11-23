-module(solution).
-export([create_data_frame/1]).

create_data_frame(Data) ->
  Headers = hd(Data),
  Rows = tl(Data),
  {ok, DataFrame} = ets:new(dataframe, [set, public, named_table]),
  lists:foreach(
    fun(Row) ->
      RowMap = lists:zip(Headers, Row),
      ets:insert(dataframe, {RowMap})
    end,
    Rows
  ),
  DataFrame.