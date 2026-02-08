-spec find_lus_length(Strs :: [unicode:unicode_binary()]) -> integer().
find_lus_length(Strs) ->
    lists:foldl(fun(Str, Max) ->
        case lists:all(fun(Other) ->
            not is_subsequence(Str, Other) orelse Str == Other
        end, Strs) of
            true -> max(Max, byte_size(Str));
            false -> Max
        end
    end, -1, Strs).

is_subsequence(A, B) ->
    is_subsequence(A, B, 0, 0).

is_subsequence(A, B, I, J) when I < byte_size(A), J < byte_size(B) ->
    case binary:at(A, I) == binary:at(B, J) of
        true -> is_subsequence(A, B, I + 1, J + 1);
        false -> is_subsequence(A, B, I, J + 1)
    end;
is_subsequence(A, _, I, _) -> I == byte_size(A).