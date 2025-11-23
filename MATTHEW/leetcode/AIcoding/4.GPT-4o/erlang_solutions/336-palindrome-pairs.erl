%% -spec palindrome_pairs(Words :: [unicode:unicode_binary()]) -> [[integer()]].
palindrome_pairs(Words) ->
    lists:foldl(fun(Word, Acc) -> 
                  find_palindrome_pairs(Word, Words, Acc) 
                end, [], Words).

find_palindrome_pairs(_, [], Acc) -> Acc;
find_palindrome_pairs(Word, [OtherWord | Rest], Acc) ->
    case is_palindrome(Word ++ OtherWord) of
        true -> find_palindrome_pairs(Word, Rest, [[Word, OtherWord] | Acc]);
        false -> find_palindrome_pairs(Word, Rest, Acc)
    end.

is_palindrome(Str) -> Str == lists:reverse(Str).
