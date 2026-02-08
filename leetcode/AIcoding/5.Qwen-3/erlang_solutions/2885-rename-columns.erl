-module(rename_columns).
-export([rename_columns/1]).

rename_columns(Students) ->
    lists:map(fun([Id, Name, Score]) -> [Id, "student_name", Score] end, Students).