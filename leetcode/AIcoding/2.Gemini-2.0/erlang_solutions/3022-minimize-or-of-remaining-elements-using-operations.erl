-module(minimize_or).
-export([minimize_or/1]).

minimize_or(Nums) ->
  N = length(Nums),
  minimize_or_helper(Nums, 0, N).

minimize_or_helper(_Nums, CurOr, 0) ->
  CurOr;
minimize_or_helper(Nums, CurOr, K) ->
  lists:foldl(fun(Sub, Acc) ->
                  NewOr = lists:foldl(fun(X, Or) ->
                                           Or bor X
                                       end, 0, Sub),
                  min(Acc, minimize_or_helper(lists:filter(fun(X) -> not lists:member(X, Sub) end, Nums), CurOr bor NewOr, K - 1))
              end, 16#ffffffff, combinations(Nums, K)).

combinations(_Nums, 0) ->
  [[]];
combinations(Nums, K) ->
  [ [H|T] || H <- Nums, T <- combinations(lists:delete(H, Nums), K - 1)].