-module(solution).
-export([count_characters/2]).

count_characters(Words, Characters) ->
    CharCounts = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(X) -> X + 1 end, 1, Acc) end, map:new(), Characters),
    lists:foldl(fun(Word, Acc) -> 
        if 
            can_form(Word, CharCounts) -> 
                Acc + length(Word); 
            true -> 
                Acc 
        end 
    end, 0, Words).

can_form(Word, CharCounts) ->
    WordCounts = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(X) -> X + 1 end, 1, Acc) end, map:new(), Word),
    maps:fold(fun(Key, Val, Acc) -> 
        case maps:find(Key, CharCounts) of 
            {ok, CharVal} -> 
                if 
                    CharVal < Val -> 
                        false; 
                    true -> 
                        Acc 
                end; 
            _ -> 
                false 
        end 
    end, true, WordCounts).