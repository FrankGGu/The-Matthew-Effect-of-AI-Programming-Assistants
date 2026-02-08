-module(solution).
-export([stone_game/1]).

stone_game(Piles) ->
    N = length(Piles),
    DP = lists:duplicate(N+1, lists:duplicate(N+1, 0)),
    stone_game_helper(Piles, DP, 0, N - 1).

stone_game_helper(Piles, DP, L, R) ->
    case L > R of
        true -> 0;
        false ->
            case lists:nth(L + 1, DP) =:= 0 of
                true ->
                    A = lists:nth(L + 1, Piles) - stone_game_helper(Piles, DP, L + 1, R),
                    B = lists:nth(R + 1, Piles) - stone_game_helper(Piles, DP, L, R - 1),
                    DP1 = lists:replace(L + 1, lists:replace(R + 1, max(A, B), DP), DP),
                    max(A, B);
                false ->
                    lists:nth(L + 1, DP)
            end
    end.

max(A, B) -> 
    if
        A > B -> A;
        true -> B
    end.