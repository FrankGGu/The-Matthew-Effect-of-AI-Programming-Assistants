-module(maximum_value_of_a_string_in_an_array).
-export([maximum_value/1]).

maximum_value(Strs) ->
  lists:max([string_value(Str) || Str <- Strs]).

string_value(Str) ->
  case string:to_integer(Str) of
    {Int, ""} ->
      Int;
    _ ->
      length(Str)
  end.