-module(solution).
-export([minimum_length/1]).

minimum_length(Words) ->
    Sorted = lists:sort(Words),
    Length = length(Sorted),
    compress(Sorted, 0, Length, []).

compress([], Acc, _, _) -> Acc;
compress([Word | Rest], Acc, Length, Seen) ->
    IsSuffix = lists:any(fun(Other) -> is_suffix(Word, Other) end, Seen),
    if
        IsSuffix -> compress(Rest, Acc, Length, Seen);
        true -> compress(Rest, Acc + length(Word) + 1, Length, [Word | Seen])
    end.

is_suffix(Suffix, Word) ->
    length(Suffix) =< length(Word),
    lists:sublist(Word, length(Word) - length(Suffix) + 1) == Suffix.