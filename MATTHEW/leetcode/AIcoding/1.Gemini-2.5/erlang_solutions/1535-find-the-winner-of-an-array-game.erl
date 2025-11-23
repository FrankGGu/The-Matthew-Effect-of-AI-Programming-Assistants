-module(solution).
-export([find_the_winner/2]).

-spec find_the_winner(Arr :: [integer()], K :: integer()) -> integer().
find_the_winner(Arr, K) ->
    [InitialWinner | RestOfArr] = Arr,
    simulate_game(RestOfArr, InitialWinner, 0, K).

simulate_game([], CurrentWinner, _ConsecutiveWins, _K) ->
    CurrentWinner;
simulate_game([Opponent | Rest], CurrentWinner, ConsecutiveWins, K) ->
    if
        CurrentWinner > Opponent ->
            NewConsecutiveWins = ConsecutiveWins + 1,
            if
                NewConsecutiveWins == K ->
                    CurrentWinner;
                true ->
                    simulate_game(Rest, CurrentWinner, NewConsecutiveWins, K)
            end;
        Opponent > CurrentWinner ->
            NewConsecutiveWins = 1,
            if
                NewConsecutiveWins == K ->
                    Opponent;
                true ->
                    simulate_game(Rest, Opponent, NewConsecutiveWins, K)
            end
    end.