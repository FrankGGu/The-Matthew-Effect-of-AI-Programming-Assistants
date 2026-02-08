-module(solution).
-export([countPartitions/1]).

countPartitions(Nums) ->
  Sum = lists:sum(Nums),
  if Sum rem 2 /= 0 then
    0
  else
    Target = Sum div 2,
    N = length(Nums),
    Mod = 1000000007,
    DP = lists:duplicate(Target + 1, 0),
    DP ! 0, 1,
    for(I, 1, N,
      fun(I) ->
        Num = lists:nth(I, Nums),
        for(J, Target, Num, -1,
          fun(J) ->
            DP ! J, (DP ! J + DP ! (J - Num)) rem Mod
          end)
      end),
    (DP ! Target * power(2, N - 1, Mod)) rem Mod
  end.

power(Base, Exp, Mod) ->
  power_helper(Base, Exp, Mod, 1).

power_helper(_, 0, _, Acc) ->
  Acc;
power_helper(Base, Exp, Mod, Acc) ->
  if Exp rem 2 == 0 then
    power_helper((Base * Base) rem Mod, Exp div 2, Mod, Acc)
  else
    power_helper(Base, Exp - 1, Mod, (Acc * Base) rem Mod)
  end.

for(Start, End, Inc, Fun) ->
  for_helper(Start, End, Inc, Fun).

for_helper(Start, End, Inc, Fun) ->
  if Inc > 0 and Start > End then
    ok
  else if Inc < 0 and Start < End then
    ok
  else
    Fun(Start),
    for_helper(Start + Inc, End, Inc, Fun)
  end.