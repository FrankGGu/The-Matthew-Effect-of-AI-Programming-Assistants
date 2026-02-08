-module(solution).
-export([num_matching_subseq/2]).

num_matching_subseq(Str, Words) ->
    WordsList = lists:map(fun(W) -> {W, list_to_binary(W)} end, Words),
    Count = lists:foldl(fun({Word, BinWord}, Acc) -> 
        if 
            matches(Str, BinWord) -> Acc + 1;
            true -> Acc 
        end 
    end, 0, WordsList),
    Count.

matches(Str, BinWord) ->
    matches(Str, BinWord, 0).

matches(_, <<>>, _) -> 
    true;
matches(Str, BinWord, Index) ->
    case lists:keyfind(BinWord, 1, Str) of
        false -> false;
        {_, Char} -> matches(tl(Str), tl(BinWord), Index + 1)
    end.