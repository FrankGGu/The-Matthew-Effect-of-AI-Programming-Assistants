-module(solution).
-export([is_almost_equivalent/2]).

is_almost_equivalent(Word1, Word2) ->
    Counts1 = count_chars(Word1),
    Counts2 = count_chars(Word2),
    lists:all(fun({C1, C2}) ->
                  abs(C1 - C2) =< 3
              end, lists:zip(Counts1, Counts2)).

count_chars(Word) ->
    InitialCounts = lists:duplicate(26, 0),
    lists:foldl(fun(Char, AccCounts) ->
                    Index = Char - $a,
                    % lists:replace_nth and lists:nth are 1-indexed
                    lists:replace_nth(Index + 1, lists:nth(Index + 1, AccCounts) + 1, AccCounts)
                end, InitialCounts, Word).