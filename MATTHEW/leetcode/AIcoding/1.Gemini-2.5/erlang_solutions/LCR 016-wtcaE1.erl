-module(solution).
-export([length_of_longest_substring/1]).

-spec length_of_longest_substring(S :: unicode:unicode_binary()) -> integer().
length_of_longest_substring(S) ->
    Chars = unicode:characters_to_list(S),
    length_of_longest_substring_recursive(Chars, 0, 0, 0, #{}).

length_of_longest_substring_recursive(Chars, CurrentIndex, StartIndex, MaxLength, CharMap) ->
    case Chars of
        [] -> MaxLength;
        [Char | Rest] ->
            NewStartIndex =
                case maps:find(Char, CharMap) of
                    {ok, PrevIndex} ->
                        max(StartIndex, PrevIndex + 1);
                    _ ->
                        StartIndex
                end,
            NewCharMap = maps:put(Char, CurrentIndex, CharMap),
            NewMaxLength = max(MaxLength, CurrentIndex - NewStartIndex + 1),
            length_of_longest_substring_recursive(Rest, CurrentIndex + 1, NewStartIndex, NewMaxLength, NewCharMap)
    end.