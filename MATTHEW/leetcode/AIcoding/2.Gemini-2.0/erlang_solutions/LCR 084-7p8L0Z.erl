-module(permute_unique).
-export([permute_unique/1]).

permute_unique(Nums) ->
  lists:usort([P || P <- permute(Nums)]).

permute([]) -> [[]];
permute(Nums) ->
  [ [H | T] || H <- lists:usort(Nums), T <- permute(Nums -- [H]) ].