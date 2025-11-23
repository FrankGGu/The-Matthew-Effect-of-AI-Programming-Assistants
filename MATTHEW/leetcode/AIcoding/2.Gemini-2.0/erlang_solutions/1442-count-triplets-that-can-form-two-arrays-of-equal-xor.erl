-module(count_triplets).
-export([count_triplets/1]).

count_triplets(Arr) ->
  N = length(Arr),
  count_triplets_helper(Arr, N, 0).

count_triplets_helper(_Arr, N, Acc) when N < 2 ->
  Acc;
count_triplets_helper(Arr, N, Acc) ->
  count_triplets_inner(Arr, 0, 0, Acc).

count_triplets_inner(_Arr, N, I, Acc) when I >= N - 1 ->
  Acc;
count_triplets_inner(Arr, N, I, Acc) ->
  count_triplets_inner2(Arr, N, I, I + 1, Acc).

count_triplets_inner2(_Arr, N, I, J, Acc) when J >= N ->
  Acc;
count_triplets_inner2(Arr, N, I, J, Acc) ->
  count_triplets_inner3(Arr, I, J, J, N, 0, 0, Acc).

count_triplets_inner3(_Arr, I, J, K, N, A, B, Acc) when K >= N ->
  Acc;
count_triplets_inner3(Arr, I, J, K, N, A, B, Acc) ->
  A1 = lists:foldl(fun(X, Sum) -> X lxor Sum end, 0, lists:sublist(Arr, I + 1, J - I)),
  B1 = lists:foldl(fun(X, Sum) -> X lxor Sum end, 0, lists:sublist(Arr, J + 1, K - J)),
  case A1 =:= B1 of
    true ->
      count_triplets_inner3(Arr, I, J, K + 1, N, A, B, Acc + 1);
    false ->
      count_triplets_inner3(Arr, I, J, K + 1, N, A, B, Acc)
  end.