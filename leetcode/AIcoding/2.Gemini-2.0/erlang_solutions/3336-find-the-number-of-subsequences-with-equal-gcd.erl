-module(solution).
-export([solve/1]).

solve(Nums) ->
  lists:foldl(fun(Num, Acc) ->
    lists:foldl(fun(Gcd, SubAcc) ->
      NewGcd = gcd(Num, Gcd),
      maps:update_with(NewGcd, fun(Count) -> Count + 1 end, 1, SubAcc)
    end, maps:update_with(Num, fun(Count) -> Count + 1 end, 1, Acc), maps:keys(Acc))
  end, #{}, Nums)
  |> maps:values()
  |> lists:foldl(fun(Count, Sum) -> (Sum + Count) rem 1000000007 end, 0).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).