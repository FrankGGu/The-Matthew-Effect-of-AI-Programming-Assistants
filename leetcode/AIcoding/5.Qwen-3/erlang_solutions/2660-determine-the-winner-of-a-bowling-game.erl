-module(bowling_game).
-export([is_winner/2]).

is_winner(Player1, Player2) ->
    Score1 = calculate_score(Player1),
    Score2 = calculate_score(Player2),
    if
        Score1 > Score2 -> player1;
        Score2 > Score1 -> player2;
        true -> draw
    end.

calculate_score(Throws) ->
    calculate_score(Throws, 0, 0, 1).

calculate_score([], Score, _, _) ->
    Score;
calculate_score([X | Xs], Score, Frame, Roll) ->
    case Frame of
        10 ->
            Score;
        _ ->
            case Roll of
                1 ->
                    if
                        X == 10 ->
                            NewScore = Score + 10 + next_two(Xs),
                            calculate_score(Xs, NewScore, Frame + 1, 1);
                        true ->
                            calculate_score(Xs, Score, Frame, 2)
                    end;
                2 ->
                    if
                        X + hd(Xs) == 10 ->
                            NewScore = Score + X + hd(Xs) + nth(2, Xs),
                            calculate_score(tl(Xs), NewScore, Frame + 1, 1);
                        true ->
                            NewScore = Score + X + hd(Xs),
                            calculate_score(tl(Xs), NewScore, Frame + 1, 1)
                    end
            end
    end.

next_two([]) ->
    0;
next_two([X | _]) ->
    X;
next_two([X, Y | _]) ->
    X + Y.

nth(1, [H | _]) ->
    H;
nth(N, [_ | T]) ->
    nth(N - 1, T).