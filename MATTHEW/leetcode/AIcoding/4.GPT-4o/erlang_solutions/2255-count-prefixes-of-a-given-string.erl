-module(solution).
-export([count_prefixes/2]).

count_prefixes(Words, S) ->
    lists:foldl(fun(Word, Acc) ->
        case string:prefix(S, Word) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Words).