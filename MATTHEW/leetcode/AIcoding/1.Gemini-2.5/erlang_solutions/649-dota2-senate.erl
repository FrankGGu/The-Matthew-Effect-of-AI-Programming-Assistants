-module(solution).
-export([predictPartyVictory/1]).

predictPartyVictory(Senate) ->
    N = length(Senate),
    {RadiantQ, DireQ} = lists:foldl(
        fun(Char, Acc) ->
            {R, D, Index} = Acc,
            case Char of
                $R -> {queue:in(Index, R), D, Index + 1};
                $D -> {R, queue:in(Index, D), Index + 1}
            end
        end,
        {queue:new(), queue:new(), 0},
        Senate
    ),

    solve(RadiantQ, DireQ, N).

solve(RadiantQ, DireQ, N) ->
    case {queue:is_empty(RadiantQ), queue:is_empty(DireQ)} of
        {true, _} -> "Dire";
        {_, true} -> "Radiant";
        {false, false} ->
            {value, R_idx, NewRadiantQ} = queue:out(RadiantQ),
            {value, D_idx, NewDireQ} = queue:out(DireQ),

            if
                R_idx < D_idx ->
                    solve(queue:in(R_idx + N, NewRadiantQ), NewDireQ, N);
                true -> % D_idx < R_idx
                    solve(NewRadiantQ, queue:in(D_idx + N, NewDireQ), N)
            end
    end.