-module(solution).
-export([solve/1]).

solve(Nums) ->
  Strings = [integer_to_list(N) || N <- Nums],
  lists:usort(fun(A, B) ->
    list_to_integer(A ++ B) > list_to_integer(B ++ A)
  end, Strings) ++ [""].