-module(solution).
-export([num_matching_subseq/2]).

num_matching_subseq(Sequences, Word) ->
    WordLength = length(Word),
    WordChars = lists:seq(0, WordLength - 1),
    WordMap = maps:from_list([{Char, []} || Char <- WordChars]),
    lists:foreach(fun(Seq) -> add_to_map(Seq, WordMap) end, Sequences),
    count_matches(Word, WordMap).

add_to_map(Seq, Map) ->
    lists:foldl(fun(Char, Acc) -> 
        case maps:get(Char, Acc, []) of
            [] -> maps:put(Char, [Seq], Acc);
            L -> maps:put(Char, [Seq | L], Acc)
        end
    end, Map, Seq).

count_matches(_, _) -> 0.