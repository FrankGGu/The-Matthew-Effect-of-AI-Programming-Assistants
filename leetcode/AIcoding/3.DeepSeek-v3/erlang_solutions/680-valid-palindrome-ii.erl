-spec valid_palindrome(S :: unicode:unicode_binary()) -> boolean().
valid_palindrome(S) ->
    check_palindrome(S, 0, byte_size(S) - 1, false).

check_palindrome(S, Left, Right, Deleted) ->
    if
        Left >= Right -> true;
        true ->
            case binary:at(S, Left) =:= binary:at(S, Right) of
                true -> check_palindrome(S, Left + 1, Right - 1, Deleted);
                false ->
                    case Deleted of
                        true -> false;
                        false ->
                            check_palindrome(S, Left + 1, Right, true) orelse
                            check_palindrome(S, Left, Right - 1, true)
                    end
            end
    end.