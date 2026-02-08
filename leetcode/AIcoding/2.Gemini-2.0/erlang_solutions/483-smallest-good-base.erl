-module(smallest_good_base).
-export([smallestGoodBase/1]).

smallestGoodBase(N) ->
  N_int = list_to_integer(integer_to_list(N)),
  MaxM = floor(math:log(N_int, 2)),
  lists:foldl(fun(M, Acc) ->
                  K = findBase(N_int, M),
                  case K of
                    false ->
                      Acc;
                    _ ->
                      case Acc of
                        false ->
                          K;
                        PrevK ->
                          min(PrevK, K)
                      end
                  end
              end, false, lists:seq(MaxM, 2)).

findBase(N, M) ->
  Low = 2,
  High = floor(math:pow(N, 1 / (M - 1))),
  findBaseHelper(N, M, Low, High).

findBaseHelper(N, M, Low, High) ->
  if Low > High ->
    false;
  true ->
    Mid = Low + (High - Low) div 2,
    Sum = sumOfGeometricSeries(Mid, M),
    case compare(Sum, N) of
      equal ->
        Mid;
      less ->
        findBaseHelper(N, M, Mid + 1, High);
      greater ->
        findBaseHelper(N, M, Low, Mid - 1)
    end
  end.

sumOfGeometricSeries(K, M) ->
  (math:pow(K, M) - 1) / (K - 1).

compare(A, B) ->
  if A < B ->
    less;
  true ->
    if A > B ->
      greater;
    true ->
      equal
    end
  end.