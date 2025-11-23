-module(permutations_ii).
-export([permute/1]).

permute(Nums) ->
    permute(Nums, []).

permute([], Acc) ->
    [lists:reverse(Acc)];
permute(Nums, Acc) ->
    Lists = lists:usort(Nums),
    [H | T] = Lists,
    case lists:member(H, Acc) of
        true -> permute(T ++ [H], Acc);
        false -> 
            [H | T] = Lists,
            Left = T ++ [H],
            Right = permute(Left -- [H], [H | Acc]),
            lists:append(Right, permute(T, Acc))
    end.