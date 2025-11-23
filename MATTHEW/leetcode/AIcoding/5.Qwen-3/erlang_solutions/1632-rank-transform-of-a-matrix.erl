-module(rank_transform_of_a_matrix).
-export([rankTransform/1]).

rankTransform(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Elements = lists:foldl(fun(Row, Acc) -> Acc ++ Row end, [], Matrix),
    Sorted = lists:usort(Elements),
    Map = maps:from_list(lists:zip(Sorted, lists:seq(1, length(Sorted)))),
    {PosMap, _} = lists:foldl(fun({Val, Index}, {Acc, Count}) ->
        case maps:find(Val, Acc) of
            {ok, _} -> {Acc, Count};
            error -> {maps:put(Val, Count, Acc), Count + 1}
        end
    end, {#{}, 1}, lists:zip(Elements, lists:seq(1, length(Elements)))),
    Result = lists:map(fun(Row) ->
        lists:map(fun(Val) -> maps:get(Val, Map) end, Row)
    end, Matrix),
    Result.