-module(largest_number).
-export([largest_number/1]).

largest_number(Nums) ->
  StrNums = [integer_to_list(N) || N <- Nums],
  SortedNums = lists:sort(fun(A, B) -> A ++ B > B ++ A end, StrNums),
  Result = string:join(lists:reverse(SortedNums), ""),
  case string:prefix(Result, "0") of
    true -> "0";
    false -> Result
  end.