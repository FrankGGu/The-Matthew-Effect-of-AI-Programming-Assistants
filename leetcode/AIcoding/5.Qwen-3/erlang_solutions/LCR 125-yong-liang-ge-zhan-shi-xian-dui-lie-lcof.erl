-module(solution).
-export([整理图书/1]).

整理图书(Books) ->
    lists:sort(Books).