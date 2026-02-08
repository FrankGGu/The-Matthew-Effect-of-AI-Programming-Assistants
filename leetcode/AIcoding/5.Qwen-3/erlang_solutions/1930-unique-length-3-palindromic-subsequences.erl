-module(solution).
-export([countPalindromes/1]).

countPalindromes(S) ->
    Count = maps:from_list([{C, 0} || C <- lists:seq($a, $z)]),
    Left = Count,
    Right = Count,
    lists:foldl(fun(C, {L, R}) ->
        NewR = maps:update_with(C, fun(V) -> V + 1 end, R),
        {L, NewR}
    end, {Left, Right}, S),
    lists:foldl(fun(C, {L, R, Acc}) ->
        NewL = maps:update_with(C, fun(V) -> V + 1 end, L),
        NewR = maps:update_with(C, fun(V) -> V - 1 end, R),
        Palindromes = maps:fold(fun(_, V, Acc2) -> Acc2 + V * (maps:get(C, NewL)) end, 0, R),
        {NewL, R, Acc + Palindromes}
    end, {Left, Right, 0}, S).

countPalindromes(S) ->
    countPalindromes(S, maps:from_list([{C, 0} || C <- lists:seq($a, $z)]), maps:from_list([{C, 0} || C <- lists:seq($a, $z)]), 0).

countPalindromes([], _, _, Acc) ->
    Acc;
countPalindromes([C | T], L, R, Acc) ->
    NewR = maps:update_with(C, fun(V) -> V + 1 end, R),
    countPalindromes(T, L, NewR, Acc).

countPalindromes([C | T], L, R, Acc) ->
    NewL = maps:update_with(C, fun(V) -> V + 1 end, L),
    NewR = maps:update_with(C, fun(V) -> V - 1 end, R),
    Palindromes = maps:fold(fun(K, V, Sum) -> Sum + V * maps:get(K, NewL) end, 0, NewR),
    countPalindromes(T, NewL, NewR, Acc + Palindromes).