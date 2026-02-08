-module(senior_citizens).
-export([number_of_senior_citizens/1]).

number_of_senior_citizens(Details) ->
  lists:foldl(
    fun(Detail, Count) ->
      Age = list_to_integer(string:sub_string(Detail, string:len(Detail) - 1, 2)),
      if
        Age > 60 ->
          Count + 1;
        true ->
          Count
      end
    end,
    0,
    Details
  ).