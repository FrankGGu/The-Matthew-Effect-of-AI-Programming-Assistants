-module(solution).
-export([get_size/1]).

get_size(DataFrame) ->
  {lists:len(DataFrame), lists:len(lists:nth(1, DataFrame))}.