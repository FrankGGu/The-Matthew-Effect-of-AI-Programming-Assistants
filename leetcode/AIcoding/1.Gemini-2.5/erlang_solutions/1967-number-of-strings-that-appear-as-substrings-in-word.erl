-module(solution).
-export([num_of_strings/2]).

num_of_strings(Patterns, Word) ->
    lists:foldl(fun(Pattern, Acc) ->
                    case string:str(Word, Pattern) of
                        0 -> Acc;
                        _ -> Acc + 1
                    end
                end, 0, Patterns).