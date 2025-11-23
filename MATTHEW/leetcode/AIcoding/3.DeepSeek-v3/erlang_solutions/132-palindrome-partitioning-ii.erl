-spec min_cut(S :: unicode:unicode_binary()) -> integer().
min_cut(S) ->
    N = byte_size(S),
    IsPalindrome = lists:duplicate(N, lists:duplicate(N, false)),
    DP = lists:duplicate(N, 0),
    {IsPalindrome1, DP1} = min_cut_helper(S, 0, N - 1, IsPalindrome, DP),
    lists:nth(N, DP1).

min_cut_helper(S, I, J, IsPalindrome, DP) when I > J ->
    {IsPalindrome, DP};
min_cut_helper(S, I, J, IsPalindrome, DP) when I =:= J ->
    IsPalindrome1 = set_palindrome(IsPalindrome, I, J, true),
    min_cut_helper(S, I, J - 1, IsPalindrome1, DP);
min_cut_helper(S, I, J, IsPalindrome, DP) ->
    IsPal = is_palindrome(S, I, J, IsPalindrome),
    IsPalindrome1 = set_palindrome(IsPalindrome, I, J, IsPal),
    if
        IsPal ->
            DP1 = set_dp(DP, J + 1, 0),
            min_cut_helper(S, I, J - 1, IsPalindrome1, DP1);
        true ->
            MinCuts = lists:min([lists:nth(K + 1, DP) + 1 || K <- lists:seq(I, J - 1)]),
            DP1 = set_dp(DP, J + 1, MinCuts),
            min_cut_helper(S, I, J - 1, IsPalindrome1, DP1)
    end.

is_palindrome(S, I, J, IsPalindrome) ->
    case I >= J of
        true -> true;
        false ->
            case binary:at(S, I) =:= binary:at(S, J) of
                true -> is_palindrome(S, I + 1, J - 1, IsPalindrome);
                false -> false
            end
    end.

set_palindrome(IsPalindrome, I, J, Val) ->
    Row = lists:nth(I + 1, IsPalindrome),
    NewRow = setnth(J + 1, Row, Val),
    setnth(I + 1, IsPalindrome, NewRow).

set_dp(DP, I, Val) ->
    setnth(I, DP, Val).

setnth(1, [_|T], X) -> [X|T];
setnth(N, [H|T], X) -> [H|setnth(N-1, T, X)].