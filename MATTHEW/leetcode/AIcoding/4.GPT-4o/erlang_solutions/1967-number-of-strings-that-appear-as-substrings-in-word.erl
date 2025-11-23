-module(solution).
-export([num_of_strings/2]).

num_of_strings(Strings, Word) ->
    lists:foldl(fun(S, Acc) -> 
        Acc + if 
            string:contains(Word, S) -> 1;
            true -> 0 
        end 
    end, 0, Strings).