-module(minimum_reverse_operations).
-export([minReverseOperations/1]).

minReverseOperations(Nums) ->
    N = length(Nums),
    {Min, _} = lists:foldl(fun(I, {Acc, Visited}) ->
        case lists:nth(I+1, Nums) of
            0 -> {Acc, Visited};
            _ ->
                {ok, NewVisited} = update_visited(Visited, I),
                {Acc + 1, NewVisited}
        end
    end, {0, []}, lists:seq(0, N-1)).

update_visited(Visited, Index) ->
    case lists:member(Index, Visited) of
        true -> {ok, Visited};
        false ->
            {ok, [Index | Visited]}
    end.