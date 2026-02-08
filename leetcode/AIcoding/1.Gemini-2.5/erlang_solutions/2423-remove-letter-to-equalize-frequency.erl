-module(solution).
-export([equalize_frequency/1]).

equalize_frequency(Word) ->
    InitialFreqs = count_chars(Word),
    try_removals(Word, InitialFreqs).

try_removals([], _InitialFreqs) ->
    false;
try_removals([Char | Rest], InitialFreqs) ->
    UpdatedFreqs = maps:update_with(Char, fun(V) -> V - 1 end, 0, InitialFreqs),
    case check_frequencies(UpdatedFreqs) of
        true -> true;
        false -> try_removals(Rest, InitialFreqs)
    end.

count_chars(Word) ->
    lists:foldl(fun(Char, Acc) -> maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc) end, #{}, Word).

check_frequencies(FreqMap) ->
    NonZeroCounts = [V || {_K, V} <- maps:to_list(FreqMap), V > 0],
    case NonZeroCounts of
        [] -> true;
        [_] -> true;
        [H | T] -> lists:all(fun(X) -> X == H end, T)
    end.