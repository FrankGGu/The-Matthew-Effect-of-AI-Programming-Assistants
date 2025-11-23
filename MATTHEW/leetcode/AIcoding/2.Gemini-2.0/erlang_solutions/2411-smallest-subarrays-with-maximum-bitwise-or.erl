-module(smallest_subarrays).
-export([smallest_subarrays/1]).

smallest_subarrays(Nums) ->
  N = length(Nums),
  MaxBits = 32,
  Last = array:new([MaxBits], {undefined, N}),
  Result = lists:map(fun(I) ->
    Num = lists:nth(I + 1, Nums),
    for(Bit = 0, Bit < MaxBits, Bit + 1,
      if
        (Num band (1 bsl Bit)) > 0 ->
          array:set(Bit, I, Last)
        true ->
          ok
      end
    ),
    MaxDist = lists:foldl(fun(Bit, Acc) ->
      case array:get(Bit, Last) of
        undefined ->
          Acc;
        Pos ->
          max(Acc, Pos - I + 1)
      end
    end, 1, lists:seq(0, MaxBits - 1)),
    MaxDist
  end, lists:seq(0, N - 1)).