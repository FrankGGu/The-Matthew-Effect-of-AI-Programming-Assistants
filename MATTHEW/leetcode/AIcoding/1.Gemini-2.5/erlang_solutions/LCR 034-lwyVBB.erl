-module(solution).
-export([isAlienSorted/2]).

compare_words([], [], _RankMap) ->
    true;
compare_words([], _Word2, _RankMap) ->
    true;
compare_words(_Word1, [], _RankMap) ->
    false;
compare_words([H1|T1], [H2|T2], RankMap) ->
    Rank1 = array:get(H1, RankMap),
    Rank2 = array:get(H2, RankMap),
    if
        Rank1 < Rank2 -> true;
        Rank1 > Rank2 -> false;
        true -> compare_words(T1, T2, RankMap)
    end.

isAlienSorted(Words, Order) ->
    RankMap = lists:foldl(
        fun({Char, Index}, Acc) ->
            array:set(Char, Index, Acc)
        end,
        array:new(256, {default, -1}),
        lists:zip(Order, lists:seq(0, length(Order)-1))
    ),
    lists:all(
        fun({Word1, Word2}) ->
            compare_words(Word1, Word2, RankMap)
        end,
        lists:zip(Words, tl(Words))
    ).