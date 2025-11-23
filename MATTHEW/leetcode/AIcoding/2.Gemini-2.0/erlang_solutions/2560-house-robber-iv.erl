-module(house_robber_iv).
-export([min_capability/2]).

min_capability(Nums, K) ->
  Len = length(Nums),
  Left = lists:min(Nums),
  Right = lists:max(Nums),
  find_min_capability(Nums, K, Left, Right, Len).

find_min_capability(Nums, K, Left, Right, Len) when Left > Right ->
  -1;
find_min_capability(Nums, K, Left, Right, Len) ->
  Mid = (Left + Right) div 2,
  if can_rob(Nums, K, Mid, Len) then
    if Left == Mid then
      if not can_rob(Nums, K, Left -1, Len) then
        Left
      else
        find_min_capability(Nums, K, 0, Left -1, Len)
      end
    else
      find_min_capability(Nums, K, Left, Mid, Len)
    end

  else
    find_min_capability(Nums, K, Mid + 1, Right, Len)
  end.

can_rob(Nums, K, Capability, Len) ->
  can_rob_helper(Nums, K, Capability, 0, 0, Len).

can_rob_helper(_, 0, _, _, _, _) ->
  true;
can_rob_helper(Nums, K, Capability, Index, Count, Len) when Index >= Len ->
  Count >= K;
can_rob_helper(Nums, K, Capability, Index, Count, Len) ->
  if lists:nth(Index + 1, Nums) =< Capability then
    can_rob_helper(Nums, K - 1, Capability, Index + 2, Count + 1, Len)
  else
    can_rob_helper(Nums, K, Capability, Index + 1, Count, Len)
  end.