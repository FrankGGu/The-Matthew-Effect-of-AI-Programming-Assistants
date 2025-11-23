-module(singleton).
-export([single_number/1]).

single_number(Nums) ->
    {Xor, _} = lists:foldl(fun(N, {Acc, Seen}) ->
        case lists:member(N, Seen) of
            true ->
                {Acc, lists:delete(N, Seen)};
            false ->
                {Acc bxor N, [N | Seen]}
        end
    end, {0, []}, Nums),
    lists:foldl(fun(N, Acc) -> Acc bxor N end, Xor, Nums).