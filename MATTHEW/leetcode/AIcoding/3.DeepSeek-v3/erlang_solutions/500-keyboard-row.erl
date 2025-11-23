-spec find_words(Words :: [unicode:unicode_binary()]) -> [unicode:unicode_binary()].
find_words(Words) ->
    Rows = [
        sets:from_list("qwertyuiop"),
        sets:from_list("asdfghjkl"),
        sets:from_list("zxcvbnm")
    ],
    lists:filter(fun(Word) -> 
        LowerWord = string:lowercase(Word),
        lists:any(fun(Row) -> 
            sets:is_subset(sets:from_list(LowerWord), Row)
        end, Rows)
    end, Words).