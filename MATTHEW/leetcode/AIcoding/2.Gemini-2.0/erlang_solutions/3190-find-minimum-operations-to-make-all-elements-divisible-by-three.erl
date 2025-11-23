-module(solution).
-export([solve/1]).

solve(Nums) ->
  lists:min([op1(Nums), op2(Nums), infinity]).

op1(Nums) ->
  case lists:member(1, Nums) of
    true -> 1;
    false -> infinity
  end.

op2(Nums) ->
  case lists:member(2, Nums) of
    true -> 1;
    false ->
      case lists:sum([if N rem 3 == 1 -> 1; true -> 0 end || N <- Nums]) >= 2 of
        true -> 2;
        false -> infinity
      end
  end.

infinity -> 100001.