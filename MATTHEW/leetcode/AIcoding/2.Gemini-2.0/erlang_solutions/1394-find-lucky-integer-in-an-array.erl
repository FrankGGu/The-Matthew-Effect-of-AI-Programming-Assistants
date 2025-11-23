-module(lucky_integer).
-export([find_lucky_integer/1]).

find_lucky_integer(Arr) ->
  Counts = lists:foldl(fun(X, Acc) ->
                                 maps:update_with(X, fun(Count) -> Count + 1 end, 1, Acc)
                         end, #{}, Arr),
  LuckyIntegers = [K || {K, V} <- maps:to_list(Counts), K == V],
  case LuckyIntegers of
    [] -> -1;
    _ -> lists:max(LuckyIntegers)
  end.