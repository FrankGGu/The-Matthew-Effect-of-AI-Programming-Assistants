-module(minimum_deletions_to_make_array_beautiful).
-export([minDeletions/1]).

minDeletions(Nums) ->
    N = length(Nums),
    {_, Result} = lists:foldl(fun(I, {Prev, Count}) ->
        case I of
            X when X >= Prev ->
                {X, Count};
            _ ->
                {X, Count + 1}
        end
    end, {hd(Nums), 0}, tl(Nums)),
    Result.