-module(solution).
-export([reshape/2]).

reshape(DF, Shape) ->
  List = df_to_list(DF),
  Rows = element(1, Shape),
  Cols = element(2, Shape),
  case length(List) =:= Rows * Cols of
    true ->
      reshape_list(List, Rows, Cols, []),
    false ->
      []
  end.

df_to_list(DF) ->
  lists:flatten([maps:values(Row) || Row <- DF]).

reshape_list([], _, _, Acc) ->
  lists:reverse(Acc);
reshape_list(List, Rows, Cols, Acc) ->
  {Row, Rest} = lists:split(Cols, List),
  reshape_list(Rest, Rows, Cols, [Row | Acc]).