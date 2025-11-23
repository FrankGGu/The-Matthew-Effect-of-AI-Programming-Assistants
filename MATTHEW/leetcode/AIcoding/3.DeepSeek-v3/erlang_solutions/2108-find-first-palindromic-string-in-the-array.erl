-spec first_palindrome(Words :: [unicode:unicode_binary()]) -> unicode:unicode_binary().
first_palindrome(Words) ->
    case lists:dropwhile(fun(Word) -> 
                            Word /= lists:reverse(Word) 
                         end, Words) of
        [] -> <<>>;
        [H|_] -> H
    end.