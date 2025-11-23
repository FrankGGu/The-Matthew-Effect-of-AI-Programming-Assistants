-module(minimize_string_length).
-export([minimize_string_length/1]).

minimize_string_length(S) ->
  length(lists:usort(string:to_list(S))).