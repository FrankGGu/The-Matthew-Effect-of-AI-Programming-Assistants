-module(solution).
-export([valid_palindrome/1]).

valid_palindrome(S) ->
    check_palindrome_sublist(S, lists:reverse(S), 1).

check_palindrome_sublist([], _ReversedSuffix, _DeletionsLeft) -> true;
check_palindrome_sublist(_Prefix, [], _DeletionsLeft) -> true;
check_palindrome_sublist(Prefix, ReversedSuffix, DeletionsLeft) ->
    HeadPrefix = hd(Prefix),
    HeadReversedSuffix = hd(ReversedSuffix),
    TailPrefix = tl(Prefix),
    TailReversedSuffix = tl(ReversedSuffix),
    if
        HeadPrefix == HeadReversedSuffix ->
            check_palindrome_sublist(TailPrefix, TailReversedSuffix, DeletionsLeft);
        DeletionsLeft > 0 ->
            check_palindrome_sublist(TailPrefix, ReversedSuffix, 0)
            orelse
            check_palindrome_sublist(Prefix, TailReversedSuffix, 0);
        true ->
            false
    end.