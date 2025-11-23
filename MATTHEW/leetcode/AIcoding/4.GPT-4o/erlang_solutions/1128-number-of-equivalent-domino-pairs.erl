-module(solution).
-export([numEquivDominoPairs/1]).

numEquivDominoPairs(Dominoes) ->
    DominoCount = lists:foldl(fun({A, B}, Acc) ->
        Key = if A < B -> {A, B}; true -> {B, A} end,
        maps:update_with(Key, fun(X) -> X + 1 end, 1, Acc)
    end, maps:empty(), Dominoes),
    maps:fold(fun(_, Count, Acc) -> Acc + (Count * (Count - 1)) div 2 end, 0, DominoCount).