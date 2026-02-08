-module(solution).
-export([calculate_score/1]).

calculate_score(Instructions) ->
    calculate_score(Instructions, 0, 0, 0).

calculate_score([], Score, _, _) ->
    Score;
calculate_score([H | T], Score, Pos, Dir) ->
    case H of
        $L ->
            calculate_score(T, Score, Pos, (Dir - 1 + 4) rem 4);
        $R ->
            calculate_score(T, Score, Pos, (Dir + 1) rem 4);
        $G ->
            NewPos = case Dir of
                         0 -> Pos + 1;
                         1 -> Pos + 16;
                         2 -> Pos - 1;
                         3 -> Pos - 16
                     end,
            calculate_score(T, Score, NewPos, Dir)
    end.