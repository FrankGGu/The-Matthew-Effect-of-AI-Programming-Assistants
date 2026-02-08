-module(kth_distinct_string).
-export([kthDistinct/2]).

kthDistinct(Arr, K) ->
  Counts = lists:foldl(fun(X, Acc) ->
                         case maps:is_key(X, Acc) of
                           true -> maps:update(X, maps:get(X, Acc) + 1, Acc);
                           false -> maps:put(X, 1, Acc)
                         end
                       end, #{}, Arr),
  Distinct = lists:filter(fun(X) -> maps:get(X, Counts) == 1 end, Arr),
  case length(Distinct) >= K of
    true -> lists:nth(K, Distinct);
    false -> ""
  end.