-module(solution).
-export([minimum_deletions/2]).

-spec minimum_deletions(S :: unicode:unicode_binary(), K :: integer()) -> integer().
minimum_deletions(S, K) ->
    CharList = unicode:characters_to_list(S),
    FreqMap = lists:foldl(
        fun(Char, Acc) ->
            maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Acc)
        end,
        #{},
        CharList
    ),

    Freqs = maps:values(FreqMap),
    NumDistinct = length(Freqs),

    if
        NumDistinct =< K ->
            0;
        true ->
            SortedFreqs = lists:sort(Freqs),
            ToEliminate = NumDistinct - K,
            Deletions = lists:sum(lists:sublist(SortedFreqs, ToEliminate)),
            Deletions
    end.