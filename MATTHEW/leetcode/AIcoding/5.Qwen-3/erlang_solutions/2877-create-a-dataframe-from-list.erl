-module(create_dataframe_from_list).
-export([create_df/1]).

create_df(List) ->
    Columns = lists:seq(1, length(hd(List))),
    Rows = lists:map(fun(Row) -> lists:zip(Columns, Row) end, List),
    {ok, Rows}.