-module(solution).
-export([num_squarefree_subsets/1]).

num_squarefree_subsets(Nums) ->
  Primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29],
  Masks = #{
    1 => 0,
    2 => 1,
    3 => 2,
    5 => 4,
    6 => 3,
    7 => 8,
    10 => 5,
    11 => 16,
    13 => 32,
    14 => 9,
    15 => 6,
    17 => 64,
    19 => 128,
    21 => 10,
    22 => 17,
    23 => 256,
    26 => 33,
    29 => 512,
    30 => 7
  },
  Mod = 1000000007,
  {Counts, _} = lists:foldl(fun(N, {Acc, MasksAcc}) ->
    case maps:get(N, Masks, undefined) of
      undefined ->
        {Acc, MasksAcc};
      _ ->
        {maps:update(N, (maps:get(N, Acc, 0) + 1), Acc), MasksAcc}
    end
  end, {#{}, Masks}, Nums),

  DP = array:new(1024, {fixed, 0}),
  DP1 = array:set(0, 1, DP),

  NewDP = maps:foldl(fun(Num, Count, AccDP) ->
    Mask = maps:get(Num, Masks),
    array:foldl(fun(MaskAcc, Val, A) ->
      if Val > 0,
        NewMask = MaskAcc bor Mask,
        array:set(NewMask, (array:get(NewMask, A) + (Val * Count) rem Mod) rem Mod, A)
      else
        A
      end
    end, AccDP, AccDP)
  end, DP1, Counts),

  Result = (array:get(0, NewDP) - 1 + Mod) rem Mod,

  Pow2 = lists:foldl(fun(_, A) -> (A * 2) rem Mod end, 1, lists:seq(1, maps:get(1, Counts, 0))),

  (Result * Pow2) rem Mod.