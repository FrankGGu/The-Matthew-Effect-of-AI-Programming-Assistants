-module(solution).
-export([count_words_with_prefix/2]).

count_words_with_prefix(Words, Prefix) ->
    lists:foldl(fun(W, Acc) -> 
        if 
            string:prefix(W, Prefix) -> 
                Acc + 1; 
            true -> 
                Acc 
        end 
    end, 0, Words).