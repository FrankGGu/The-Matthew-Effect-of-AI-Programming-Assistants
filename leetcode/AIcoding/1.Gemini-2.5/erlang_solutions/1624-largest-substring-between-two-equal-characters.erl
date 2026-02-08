-module(solution).
-export([largest_substring_between_two_equal_characters/1]).

largest_substring_between_two_equal_characters(S) ->
    {MaxLen, _, _} = lists:foldl(
        fun(Char, {CurrentMaxLen, FirstOccurrences, CurrentIndex}) ->
            case maps:find(Char, FirstOccurrences) of
                {ok, FirstIndex} ->
                    Len = CurrentIndex - FirstIndex - 1,
                    {max(CurrentMaxLen, Len), FirstOccurrences, CurrentIndex + 1};
                error ->
                    NewFirstOccurrences = maps:put(Char, CurrentIndex, FirstOccurrences),
                    {CurrentMaxLen, NewFirstOccurrences, CurrentIndex + 1}
            end
        end,
        {-1, #{}, 0},
        S
    ),
    MaxLen.