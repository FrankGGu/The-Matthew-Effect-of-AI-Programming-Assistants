-module(solution).
-export([shortestCompletingWord/2]).

shortestCompletingWord(licensePlate, words) ->
    LicenseChars = lists:filter(fun(C) -> C >= $a andalso C =< $z end, string:to_lower(licensePlate)),
    Counts = count_chars(LicenseChars),
    lists:foldl(fun(Word, Acc) -> 
        if 
            can_complete(Counts, count_chars(Word)) -> 
                case Acc of 
                    [] -> [Word];
                    [H | _] when string:length(H) > string:length(Word) -> [Word];
                    _ -> Acc
                end;
            true -> Acc
        end, [], words).

count_chars(List) ->
    lists:foldl(fun(C, Acc) -> 
        maps:update_with(C, fun(N) -> N + 1 end, 1, Acc)
    end, #{}, List).

can_complete(Needed, Available) ->
    maps:fold(fun(Key, Value, Acc) -> 
        Acc andalso (maps:get(Key, Available, 0) >= Value)
    end, true, Needed).