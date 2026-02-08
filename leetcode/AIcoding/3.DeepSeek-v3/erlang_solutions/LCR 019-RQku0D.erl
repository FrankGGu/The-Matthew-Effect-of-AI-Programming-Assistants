-spec valid_palindrome(S :: unicode:unicode_binary()) -> boolean().
valid_palindrome(S) ->
    valid_palindrome_helper(S, 0, byte_size(S) - 1, false).

valid_palindrome_helper(S, Left, Right, Deleted) ->
    if
        Left >= Right -> true;
        true ->
            case binary:at(S, Left) =:= binary:at(S, Right) of
                true -> valid_palindrome_helper(S, Left + 1, Right - 1, Deleted);
                false ->
                    case Deleted of
                        true -> false;
                        false ->
                            valid_palindrome_helper(S, Left + 1, Right, true) orelse
                            valid_palindrome_helper(S, Left, Right - 1, true)
                    end
            end
    end.