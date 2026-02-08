-module(solution).
-export([odd_string_difference/1]).

diff_array(Word) ->
    [C - PrevC || {C, PrevC} <- lists:zip(lists:tl(Word), lists:droplast(Word))].

odd_string_difference(Words) ->
    DiffWordPairs = [{diff_array(W), W} || W <- Words],

    DiffCounts = lists:foldl(
        fun({DiffArr, _}, Acc) ->
            maps:update_with(DiffArr, fun(Count) -> Count + 1 end, 1, Acc)
        end,
        maps:new(),
        DiffWordPairs
    ),

    {OddDiffArr, _Count} = lists:keyfind(1, 2, maps:to_list(DiffCounts)),

    [OddWord] = [W || {DiffArr, W} <- DiffWordPairs, DiffArr == OddDiffArr],
    OddWord.