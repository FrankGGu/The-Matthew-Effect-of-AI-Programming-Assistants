-module(solution).
-export([checkPalindromeFormation/2]).

-spec checkPalindromeFormation(A :: unicode:chardata(), B :: unicode:chardata()) -> boolean().
checkPalindromeFormation(A, B) ->
    A_list = unicode:characters_to_list(A),
    B_list = unicode:characters_to_list(B),
    check_formation(A_list, B_list) orelse check_formation(B_list, A_list).

-spec check_formation(S1 :: [char()], S2 :: [char()]) -> boolean().
check_formation(S1, S2) ->
    N = length(S1),
    S2_rev = lists:reverse(S2),
    check_match_and_pal(S1, S2_rev, S1, S2, 0, N - 1).

-spec check_match_and_pal(S1_curr :: [char()], S2_rev_curr :: [char()], S1_original :: [char()], S2_original :: [char()], L :: integer(), R :: integer()) -> boolean().
check_match_and_pal(S1_curr, S2_rev_curr, S1_original, S2_original, L, R) ->
    if
        L >= R ->
            true; % The remaining part is empty or a single character, which is a palindrome.
        true ->
            [H1 | T1] = S1_curr,
            [H2 | T2] = S2_rev_curr,
            if
                H1 == H2 ->
                    check_match_and_pal(T1, T2, S1_original, S2_original, L + 1, R - 1);
                true ->
                    %% Mismatch found. The outer parts S1[0...L-1] and S2[R+1...N-1] (reversed) matched.
                    %% Now check if the remaining middle part of S1 (S1[L...R])
                    %% OR the remaining middle part of S2 (S2[L...R]) is a palindrome.
                    is_palindrome_from_sublist(S1_original, L, R) orelse is_palindrome_from_sublist(S2_original, L, R)
            end
    end.

-spec is_palindrome_from_sublist(List :: [char()], StartIndex :: integer(), EndIndex :: integer()) -> boolean().
is_palindrome_from_sublist(List, StartIndex, EndIndex) ->
    if
        StartIndex > EndIndex ->
            true; % An empty sublist is a palindrome.
        true ->
            SubListLength = EndIndex - StartIndex + 1,
            SubList = lists:sublist(List, StartIndex + 1, SubListLength),
            is_palindrome(SubList)
    end.

-spec is_palindrome(List :: [char()]) -> boolean().
is_palindrome(List) ->
    is_palindrome_helper(List, lists:reverse(List)).

-spec is_palindrome_helper(List :: [char()], ReversedList :: [char()]) -> boolean().
is_palindrome_helper([], []) -> true;
is_palindrome_helper([_], [_]) -> true;
is_palindrome_helper([H1 | T1], [H2 | T2]) ->
    H1 == H2 andalso is_palindrome_helper(T1, T2).