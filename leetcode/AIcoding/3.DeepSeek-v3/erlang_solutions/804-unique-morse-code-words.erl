-spec unique_morse_representations(Words :: [unicode:unicode_binary()]) -> integer().
unique_morse_representations(Words) ->
    MorseCodes = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."],
    lists:foldl(
        fun(Word, Acc) ->
            Morse = lists:concat(
                lists:map(
                    fun(Char) ->
                        lists:nth(Char - $a + 1, MorseCodes)
                    end,
                    binary_to_list(Word)
                )
            ),
            sets:add_element(Morse, Acc)
        end,
        sets:new(),
        Words
    ),
    sets:size(sets:from_list(
        lists:map(
            fun(Word) ->
                lists:concat(
                    lists:map(
                        fun(Char) ->
                            lists:nth(Char - $a + 1, MorseCodes)
                        end,
                        binary_to_list(Word)
                    )
                )
            end,
            Words
        )
    )).