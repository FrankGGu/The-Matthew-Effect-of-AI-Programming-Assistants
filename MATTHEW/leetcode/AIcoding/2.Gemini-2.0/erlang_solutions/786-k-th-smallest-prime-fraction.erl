-module(kth_smallest_prime_fraction).
-export([kth_smallest_prime_fraction/3]).

kth_smallest_prime_fraction(Arr, K, N) ->
  binary_search(Arr, 0.0, 1.0, K, N).

binary_search(Arr, Low, High, K, N) ->
  Mid = (Low + High) / 2.0,
  {Count, MaxFrac} = count_less_equal(Arr, Mid, N),
  case Count == K of
    true ->
      case count_less_equal(Arr, Mid - 1e-9, N) of
        {Count2, _} when Count2 < K ->
          find_fraction(Arr, MaxFrac, N);
        _ ->
          binary_search(Arr, Low, Mid, K, N)
      end;
    false ->
      case Count < K of
        true ->
          binary_search(Arr, Mid, High, K, N);
        false ->
          binary_search(Arr, Low, Mid, K, N)
      end
  end.

count_less_equal(Arr, Value, N) ->
  count_less_equal(Arr, Value, N, 0, 0.0).

count_less_equal(Arr, Value, N, Count, MaxFrac) ->
  count_less_equal(Arr, Value, N, 0, N - 1, Count, MaxFrac).

count_less_equal(Arr, Value, N, I, J, Count, MaxFrac) ->
  if
    I >= N orelse J < 0 ->
      {Count, MaxFrac};
    true ->
      case Arr ! I / Arr ! J =< Value of
        true ->
          NewCount = Count + J + 1,
          NewMaxFrac = max(MaxFrac, Arr ! I / Arr ! J),
          count_less_equal(Arr, Value, N, I + 1, N - 1, NewCount, NewMaxFrac);
        false ->
          count_less_equal(Arr, Value, N, I, J - 1, Count, MaxFrac)
      end
  end.

find_fraction(Arr, Value, N) ->
  find_fraction(Arr, Value, N, 0, N - 1, []).

find_fraction(Arr, Value, N, I, J, Acc) ->
  if
    I >= N orelse J < 0 ->
      lists:nth(1, lists:sort(Acc));
    true ->
      case abs(Arr ! I / Arr ! J - Value) < 1e-9 of
        true ->
          find_fraction(Arr, Value, N, I + 1, N - 1, [{Arr ! I, Arr ! J} | Acc]);
        false ->
          case Arr ! I / Arr ! J < Value of
            true ->
              find_fraction(Arr, Value, N, I + 1, J, Acc);
            false ->
              find_fraction(Arr, Value, N, I, J - 1, Acc)
          end
      end
  end.

max(A, B) ->
  if
    A > B -> A;
    true -> B
  end.