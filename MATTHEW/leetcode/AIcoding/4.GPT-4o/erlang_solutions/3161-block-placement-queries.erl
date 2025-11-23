-module(solution).
-export([blockPlacementQueries/2]).

blockPlacementQueries(Blocks, Queries) ->
    MaxSize = lists:max(Blocks),
    BlockCount = length(Blocks),
    QueriesCount = length(Queries),
    Result = lists:map(fun(Query) -> count_blocks(Blocks, Query, MaxSize, BlockCount) end, Queries),
    Result.

count_blocks(Blocks, Query, MaxSize, BlockCount) ->
    {X, Y} = Query,
    lists:foldl(fun(Height, Acc) ->
        if
            Height >= X andalso Height =< Y -> Acc + 1;
            true -> Acc
        end
    end, 0, Blocks).