-spec count_substrings(S :: unicode:unicode_binary()) -> integer().
count_substrings(S) ->
    N = byte_size(S),
    Count = 0,
    count_substrings(S, N, Count).

count_substrings(S, N, Count) ->
    case N of
        0 -> Count;
        _ ->
            NewCount = Count + count_palindromes(S, N),
            count_substrings(S, N - 1, NewCount)
    end.

count_palindromes(S, Len) ->
    case Len of
        0 -> 0;
        _ ->
            SubCount = count_palindromes(S, Len - 1),
            case is_palindrome(S, Len) of
                true -> SubCount + 1;
                false -> SubCount
            end
    end.

is_palindrome(S, Len) ->
    case Len =< 1 of
        true -> true;
        false ->
            case binary:at(S, 0) =:= binary:at(S, Len - 1) of
                true -> is_palindrome(binary:part(S, 1, Len - 2), Len - 2);
                false -> false
            end
    end.