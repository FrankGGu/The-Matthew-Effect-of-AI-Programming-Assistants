-module(solution).
-export([k_successive_games/2]).

k_successive_games(Results, K) ->
    k_successive_games(Results, K, 0, 1).

k_successive_games([], _, _, _) ->
    -1;
k_successice_games([H | T], K, Count, Player) ->
    if
        H == Player ->
            NewCount = Count + 1,
            if
                NewCount >= K ->
                    Player;
                true ->
                    k_successive_games(T, K, NewCount, Player)
            end;
        true ->
            k_successive_games(T, K, 0, H)
    end.