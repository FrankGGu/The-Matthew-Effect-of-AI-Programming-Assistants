-module(ransom_note).
-export([can_construct/2]).

can_construct(RansomNote, Magazine) ->
    CountR = count_chars(RansomNote),
    CountM = count_chars(Magazine),
    maps:fold(fun(Key, Val, Acc) ->
        case maps:get(Key, CountM, 0) of
            V when V >= Val -> Acc;
            _ -> false
        end
    end, true, CountR).

count_chars(Str) ->
    lists:foldl(fun(Char, Acc) ->
        maps:update_with(Char, fun(X) -> X + 1 end, 1, Acc)
    end, maps:new(), Str).