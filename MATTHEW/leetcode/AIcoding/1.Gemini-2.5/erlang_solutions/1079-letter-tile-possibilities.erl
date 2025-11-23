-module(solution).
-export([numTilePossibilities/1]).

numTilePossibilities(Tiles) ->
    CharCounts = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) end, #{}, Tiles),
    count_possibilities(CharCounts).

count_possibilities(Counts) ->
    Total = 0,
    maps:fold(fun(Char, Count, Acc) ->
        if
            Count > 0 ->
                NewCounts = maps:update(Char, Count - 1, Counts),
                Acc + 1 + count_possibilities(NewCounts);
            true ->
                Acc
        end
    end, Total, Counts).