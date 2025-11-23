-module(solution).
-export([can_type/2]).

can_type(Text, BrokenLetters) ->
    TextWords = string:tokens(Text, " "),
    BrokenSet = sets:from_list(string:to_list(BrokenLetters)),
    lists:foldl(fun(Word, Acc) -> 
        if 
            sets:is_subset(string:to_list(Word), BrokenSet) -> Acc 
        else 
            Acc + 1 
        end 
    end, 0, TextWords).