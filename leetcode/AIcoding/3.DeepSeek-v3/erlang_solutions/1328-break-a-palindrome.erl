-spec break_palindrome(Palindrome :: unicode:unicode_binary()) -> unicode:unicode_binary().
break_palindrome(Palindrome) ->
    case binary:split(Palindrome, <<>>, [global, trim]) of
        [<<>>] -> <<>>;
        Chars ->
            case break_palindrome(Chars, 0, length(Chars)) of
                not_found -> 
                    case length(Chars) of
                        1 -> <<>>;
                        _ -> 
                            Last = lists:last(Chars),
                            NewLast = case Last of
                                $a -> $b;
                                _ -> $a
                            end,
                            list_to_binary(lists:sublist(Chars, length(Chars) - 1) ++ [NewLast]
                    end;
                Result -> list_to_binary(Result)
            end
    end.

break_palindrome(Chars, Index, Length) when Index < Length div 2 ->
    case lists:nth(Index + 1, Chars) of
        $a -> break_palindrome(Chars, Index + 1, Length);
        _ ->
            NewChars = lists:sublist(Chars, Index) ++ [$a] ++ lists:nthtail(Index + 1, Chars),
            NewChars
    end;
break_palindrome(_, _, _) ->
    not_found.