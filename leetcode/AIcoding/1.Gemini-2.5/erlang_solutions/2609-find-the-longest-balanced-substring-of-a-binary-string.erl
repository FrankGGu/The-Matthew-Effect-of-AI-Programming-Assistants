-module(solution).
-export([longestBalancedSubstring/1]).

longestBalancedSubstring(S) ->
    find_max_balanced(S, 0).

find_max_balanced([], MaxLen) -> MaxLen;
find_max_balanced([$1 | T], MaxLen) -> find_max_balanced(T, MaxLen);
find_max_balanced([$0 | _] = S, MaxLen) ->
    {Zeros, RestAfterZeros} = count_char(S, $0, 0),
    case RestAfterZeros of
        [$1 | _] = OnesPart ->
            {Ones, _RestAfterOnes} = count_char(OnesPart, $1, 0),
            CurrentLen = 2 * min(Zeros, Ones),
            NewMaxLen = max(MaxLen, CurrentLen),
            find_max_balanced(tl(S), NewMaxLen);
        _ ->
            find_max_balanced(tl(S), MaxLen)
    end.

count_char([], _Char, Count) -> {Count, []};
count_char([Char | T], Char, Count) -> count_char(T, Char, Count + 1);
count_char(S, _Char, Count) -> {Count, S}.