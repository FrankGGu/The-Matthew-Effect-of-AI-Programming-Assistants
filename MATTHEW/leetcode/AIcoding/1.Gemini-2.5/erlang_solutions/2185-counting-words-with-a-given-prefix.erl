-module(solution).
-export([prefix_count/2]).

prefix_count(Words, Prefix) ->
    lists:foldl(fun(Word, Acc) ->
                    case string:starts_with(Word, Prefix) of
                        true -> Acc + 1;
                        false -> Acc
                    end
                end, 0, Words).