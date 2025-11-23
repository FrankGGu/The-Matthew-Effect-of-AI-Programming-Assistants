-module(permutations).
-export([permute/1]).

permute([]) -> [[]];
permute(List) ->
    lists:foldl(fun(El, Acc) ->
        lists:append(
            lists:map(fun(Sub) -> [El | Sub] end, Acc),
            []
        )
    end, [[]], List).