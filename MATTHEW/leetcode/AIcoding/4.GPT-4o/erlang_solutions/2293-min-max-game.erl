-module(solution).
-export([min_max_game/1]).

min_max_game(List) ->
    min_max_game(List, true).

min_max_game([], _) ->
    0;
min_max_game([H | T], IsMin) ->
    Next = min_max_game(T, not IsMin),
    case IsMin of
        true -> 
            min(H, Next);
        false -> 
            max(H, Next)
    end.

min(A, B) when A < B -> A;
min(_, B) -> B.

max(A, B) when A > B -> A;
max(_, B) -> B.