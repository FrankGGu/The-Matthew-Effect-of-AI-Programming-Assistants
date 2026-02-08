-spec longest_palindrome(S :: unicode:unicode_binary()) -> integer().
longest_palindrome(S) ->
    N = byte_size(S),
    Max = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, InnerAcc) ->
            Sub = binary:part(S, I, J - I + 1),
            case is_palindrome(Sub) of
                true -> max(InnerAcc, J - I + 1);
                false -> InnerAcc
            end
        end, Acc, lists:seq(I, N - 1))
    end, Max, lists:seq(0, N - 1)).

is_palindrome(Bin) ->
    Size = byte_size(Bin),
    is_palindrome_helper(Bin, 0, Size - 1).

is_palindrome_helper(Bin, Left, Right) when Left >= Right ->
    true;
is_palindrome_helper(Bin, Left, Right) ->
    case binary:at(Bin, Left) =:= binary:at(Bin, Right) of
        true -> is_palindrome_helper(Bin, Left + 1, Right - 1);
        false -> false
    end.