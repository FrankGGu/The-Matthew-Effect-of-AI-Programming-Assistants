-spec vowel_strings(Words :: [unicode:unicode_binary()], Left :: integer(), Right :: integer()) -> integer().
vowel_strings(Words, Left, Right) ->
    Vowels = sets:from_list("aeiou"),
    SubList = lists:sublist(Words, Left + 1, Right - Left + 1),
    lists:foldl(fun(Word, Acc) ->
        case binary_to_list(Word) of
            [First | _] = Chars ->
                Last = lists:last(Chars),
                case {sets:is_element(First, Vowels), sets:is_element(Last, Vowels)} of
                    {true, true} -> Acc + 1;
                    _ -> Acc
                end;
            _ -> Acc
        end
    end, 0, SubList).