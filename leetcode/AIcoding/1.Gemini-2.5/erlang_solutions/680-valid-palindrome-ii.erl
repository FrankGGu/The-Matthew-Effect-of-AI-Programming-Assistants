-module(solution).
-export([validPalindrome/1]).

validPalindrome(S) ->
    Bin = list_to_binary(S),
    Len = byte_size(Bin),
    check(Bin, 0, Len - 1, 1).

check(Bin, Left, Right, Deletions) when Left >= Right ->
    true;
check(Bin, Left, Right, Deletions) ->
    CharLeft = binary:at(Bin, Left),
    CharRight = binary:at(Bin, Right),
    if
        CharLeft == CharRight ->
            check(Bin, Left + 1, Right - 1, Deletions);
        Deletions > 0 ->
            check(Bin, Left + 1, Right, Deletions - 1) orelse
            check(Bin, Left, Right - 1, Deletions - 1);
        true ->
            false
    end.