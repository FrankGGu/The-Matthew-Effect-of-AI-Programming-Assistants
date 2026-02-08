-module(solution).
-export([create_column/2]).

create_column(Students, ColumnName) ->
    lists:map(fun(Student) -> Student#{ColumnName => 0} end, Students).