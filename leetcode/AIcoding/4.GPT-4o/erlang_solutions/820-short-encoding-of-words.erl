-module(solution).
-export([minimum_length_encoding/1]).

minimum_length_encoding(Words) ->
    UniqueWords = lists:usort(Words),
    EncodedWords = [Word || Word <- UniqueWords, not lists:any(fun(X) -> string:prefix(Word, X) end, UniqueWords -- [Word])],
    lists:sum(lists:map(fun(Word) -> string:length(Word) + 1 end, EncodedWords)).