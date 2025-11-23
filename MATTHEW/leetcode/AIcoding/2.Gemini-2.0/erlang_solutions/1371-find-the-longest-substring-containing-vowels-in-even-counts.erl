-module(longest_even_vowels).
-export([find_the_longest_substring/1]).

find_the_longest_substring(S) ->
    find_the_longest_substring(S, 0, #{0 => -1}, 0, 0, 0, 0, 0).

find_the_longest_substring([], MaxLen, _, _, _, _, _, _, _) ->
    MaxLen;
find_the_longest_substring([H | T], MaxLen, Seen, Index, A, E, I, O, U) ->
    case H of
        $a ->
            NewA = 1 - A;
            NewE = E;
            NewI = I;
            NewO = O;
            NewU = U;
        $e ->
            NewA = A;
            NewE = 1 - E;
            NewI = I;
            NewO = O;
            NewU = U;
        $i ->
            NewA = A;
            NewE = E;
            NewI = 1 - I;
            NewO = O;
            NewU = U;
        $o ->
            NewA = A;
            NewE = E;
            NewI = I;
            NewO = 1 - O;
            NewU = U;
        $u ->
            NewA = A;
            NewE = E;
            NewI = I;
            NewO = O;
            NewU = 1 - U;
        _ ->
            NewA = A;
            NewE = E;
            NewI = I;
            NewO = O;
            NewU = U
    end,
    State = (NewA bsl 4) bor (NewE bsl 3) bor (NewI bsl 2) bor (NewO bsl 1) bor NewU,
    case maps:is_key(State, Seen) of
        true ->
            FirstIndex = maps:get(State, Seen),
            NewMaxLen = max(MaxLen, Index - FirstIndex);
            find_the_longest_substring(T, NewMaxLen, Seen, Index + 1, NewA, NewE, NewI, NewO, NewU);
        false ->
            NewSeen = maps:put(State, Index, Seen),
            find_the_longest_substring(T, MaxLen, NewSeen, Index + 1, NewA, NewE, NewI, NewO, NewU)
    end.