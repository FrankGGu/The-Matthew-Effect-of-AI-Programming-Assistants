-module(short_encoding).
-export([minimum_length_encoding/1]).

minimum_length_encoding(Words) ->
    UniqueWords = sets:from_list(Words),
    Filtered = sets:filter(fun(Word) -> 
        not lists:any(fun(Other) -> 
            Other =/= Word andalso string:str(Other, Word) =/= 0 andalso 
            string:equal(string:substr(Other, length(Other) - length(Word) + 1), Word)
        end, sets:to_list(UniqueWords))
    end, UniqueWords),
    lists:sum([length(Word) + 1 || Word <- sets:to_list(Filtered)]).