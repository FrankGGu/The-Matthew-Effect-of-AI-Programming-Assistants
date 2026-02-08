-module(solution).
-export([transform/2]).

transform(DataFrame, Column) ->
  [lists:zipwith(fun(Row) -> lists:append(Row, [Column(Row)]), DataFrame)].