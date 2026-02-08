-module(anagrams_in_string).
-export([find_anagrams/2]).

find_anagrams(<<>>, _) -> [];
find_anagrams(S, P) ->
    LenP = erlang:length(P),
    LenS = erlang:length(S),
    if
        LenP > LenS -> [];
        true ->
            PCount = count_chars(P),
            SCount = count_chars(erlang:binary_part(S, 0, LenP)),
            find_anagrams(S, P, PCount, SCount, 0, [])
    end.

count_chars(B) ->
    lists:foldl(fun(Char, Acc) -> maps:update_with(Char, fun(X) -> X + 1 end, 1, Acc) end, #{}, binary_to_list(B)).

find_anagrams(_, _, _, _, _, Acc) when Acc /= [] -> lists:reverse(Acc);
find_anagrams(S, P, PCount, SCount, Index, Acc) ->
    case maps:equality(SCount, PCount) of
        true -> find_anagrams(S, P, PCount, SCount, Index + 1, [Index | Acc]);
        false -> 
            NextIndex = Index + 1,
            NextChar = erlang:element(NextIndex + 1, S),
            NewSCount = maps:update_with(NextChar, fun(X) -> X + 1 end, 1, SCount),
            RemoveChar = erlang:element(Index + 1, S),
            NewSCount2 = maps:update_with(RemoveChar, fun(X) -> X - 1 end, 0, NewSCount),
            find_anagrams(S, P, PCount, NewSCount2, NextIndex, Acc)
    end.