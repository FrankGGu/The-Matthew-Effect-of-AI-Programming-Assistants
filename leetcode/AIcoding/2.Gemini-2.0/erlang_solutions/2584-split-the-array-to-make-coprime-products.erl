-module(split_array_coprime).
-export([max_split_parts/1]).

max_split_parts(Nums) ->
  max_split_parts(Nums, 0, []).

max_split_parts([], Acc, _) ->
  Acc;
max_split_parts([H|T], Acc, Factors) ->
  NewFactors = union(Factors, get_factors(H)),
  case T of
    [] ->
      Acc + 1;
    _ ->
      case lists:all(fun(X) -> not lists:member(X, get_factors(lists:foldl(fun(X,A) -> X*A end, 1, T))) end, NewFactors) of
        true ->
          max_split_parts(T, Acc + 1, []);
        false ->
          max_split_parts(T, Acc, NewFactors)
      end
  end.

get_factors(N) ->
  get_factors(N, 2, []).

get_factors(1, _, Acc) ->
  lists:usort(Acc);
get_factors(N, I, Acc) when I * I > N ->
  lists:usort(Acc ++ [N]);
get_factors(N, I, Acc) ->
  case N rem I of
    0 ->
      get_factors(N div I, I, Acc ++ [I]);
    _ ->
      get_factors(N, I + 1, Acc)
  end.

union(A, B) ->
  lists:usort(A ++ B).