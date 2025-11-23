-module(solution).
-export([max_vowels/2]).

max_vowels(S, K) ->
    Vowels = sets:from_list([$a, $e, $i, $o, $u]),
    max_vowels(S, K, 0, 0, Vowels).

max_vowels([], _, _, Max, _) ->
    Max;
max_vowels([C | T], K, Index, Current, Vowels) ->
    case sets:is_element(C, Vowels) of
        true ->
            NewCurrent = Current + 1;
        false ->
            NewCurrent = Current
    end,
    if
        Index >= K ->
            PrevChar = lists:nth(Index - K + 1, S),
            if
                sets:is_element(PrevChar, Vowels) ->
                    NewCurrent = NewCurrent - 1;
                true ->
                    ok
            end;
        true ->
            ok
    end,
    NewMax = if
        NewCurrent > Current -> NewCurrent;
        true -> Current
    end,
    max_vowels(T, K, Index + 1, NewCurrent, Vowels).