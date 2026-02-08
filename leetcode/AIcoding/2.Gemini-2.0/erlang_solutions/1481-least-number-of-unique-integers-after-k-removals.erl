-module(least_unique_integers).
-export([find_least_num_of_unique_ints/2]).

find_least_num_of_unique_ints(Arr, K) ->
  Counts = lists:foldl(fun(X, Acc) ->
                                 case maps:is_key(X, Acc) of
                                   true -> maps:update(X, maps:get(X, Acc) + 1, Acc);
                                   false -> maps:put(X, 1, Acc)
                                 end
                         end, #{}, Arr),
  Freqs = lists:sort(lists:usort(maps:values(Counts))),
  find_least_num_of_unique_ints_helper(Freqs, K, 0).

find_least_num_of_unique_ints_helper([], _K, Acc) ->
  Acc;
find_least_num_of_unique_ints_helper([H|T], K, Acc) ->
  if H =< K ->
    find_least_num_of_unique_ints_helper(T, K - H, Acc);
  true ->
    Acc + length([H|T])
  end.