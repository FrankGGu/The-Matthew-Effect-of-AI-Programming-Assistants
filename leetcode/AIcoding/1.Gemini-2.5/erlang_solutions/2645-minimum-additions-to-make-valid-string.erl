-module(solution).
-export([minimum_additions/1]).

char_to_index($a) -> 0;
char_to_index($b) -> 1;
char_to_index($c) -> 2.

minimum_additions(Word) ->
    {TotalAdditions, FinalExpectedCharIndex} = lists:foldl(
        fun(Char, {AccAdditions, AccExpectedCharIndex}) ->
            CharIndex = char_to_index(Char),
            if
                CharIndex == AccExpectedCharIndex ->
                    {AccAdditions, (AccExpectedCharIndex + 1) rem 3};
                true ->
                    AddCount = (CharIndex - AccExpectedCharIndex + 3) rem 3,
                    {AccAdditions + AddCount, (CharIndex + 1) rem 3}
            end
        end,
        {0, 0},
        Word
    ),
    TotalAdditions + (3 - FinalExpectedCharIndex) rem 3.