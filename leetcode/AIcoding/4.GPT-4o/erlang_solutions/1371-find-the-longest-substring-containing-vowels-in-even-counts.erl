-module(solution).
-export([findTheLongestSubstring/1]).

findTheLongestSubstring(S) ->
    find_longest(S, 0, 0, [{0, -1}], #{0 => 1, 1 => 0, 2 => 0, 3 => 0, 4 => 0}).

find_longest([], _, MaxLength, Acc, _) -> 
    MaxLength;
find_longest([H | T], State, MaxLength, Acc, Count) ->
    NewState = case lists:member(H, "aeiou") of
        true -> (State + (1 bsr (index(H) * 2))) band 31;
        false -> State
    end,
    case maps:find(NewState, Acc) of
        {ok, Index} -> 
            NewMaxLength = max(MaxLength, length(T) + Index + 1);
            find_longest(T, NewState, NewMaxLength, Acc, Count);
        _ -> 
            NewAcc = maps:put(NewState, length(T) + 1, Acc);
            find_longest(T, NewState, MaxLength, NewAcc, Count)
    end.

index(Char) ->
    case Char of
        $a -> 0;
        $e -> 1;
        $i -> 2;
        $o -> 3;
        $u -> 4;
        _ -> -1
    end.