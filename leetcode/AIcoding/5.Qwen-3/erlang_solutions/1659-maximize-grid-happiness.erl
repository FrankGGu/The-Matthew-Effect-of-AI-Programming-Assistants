-module(maximize_grid_happiness).
-export([maximizeGridHappiness/2]).

maximizeGridHappiness(M, N) ->
    max_happiness(M, N, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0).

max_happiness(_, _, _, _, _, _, _, _, _, _, _, _, _) -> 0;
max_happiness(M, N, R, C, A, B, C1, C2, C3, C4, C5, C6, C7) ->
    if
        R >= M -> 0;
        true ->
            case C of
                N ->
                    max_happiness(M, N, R + 1, 0, A, B, C1, C2, C3, C4, C5, C6, C7);
                _ ->
                    % Choose to place a child (0)
                    Val0 = max_happiness(M, N, R, C + 1, A, B, C1, C2, C3, C4, C5, C6, C7),
                    % Choose to place a student (1)
                    Val1 = 0,
                    % Choose to place a teacher (2)
                    Val2 = 0,
                    % Choose to place a worker (3)
                    Val3 = 0,
                    % Choose to place a doctor (4)
                    Val4 = 0,
                    % Choose to place a lawyer (5)
                    Val5 = 0,
                    % Choose to place a engineer (6)
                    Val6 = 0,
                    max(Val0, Val1, Val2, Val3, Val4, Val5, Val6)
            end
    end.

max(Val0, Val1, Val2, Val3, Val4, Val5, Val6) ->
    lists:max([Val0, Val1, Val2, Val3, Val4, Val5, Val6]).