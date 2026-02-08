-module(stable_binary_arrays1).
-export([find_all_stable_binary_arrays/2]).

find_all_stable_binary_arrays(N, K) ->
  find_all_stable_binary_arrays_helper(N, K, []).

find_all_stable_binary_arrays_helper(0, 0, Acc) ->
  [lists:reverse(Acc)];
find_all_stable_binary_arrays_helper(0, _, _) ->
  [];
find_all_stable_binary_arrays_helper(_, 0, _) ->
  [];
find_all_stable_binary_arrays_helper(N, K, Acc) ->
  case N > K of
    true ->
      find_all_stable_binary_arrays_helper(N - 1, K, [0 | Acc]) ++
      find_all_stable_binary_arrays_helper(N - 1, K - 1, [1 | Acc]);
    false ->
      find_all_stable_binary_arrays_helper(N - 1, K - 1, [1 | Acc])
  end.