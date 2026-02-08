-module(num_ways_to_paint_n_3_grid).
-export([numWays/1]).

numWays(N) ->
    if
        N == 0 -> 0;
        N == 1 -> 6;
        true ->
            {A, B} = lists:foldl(fun(_I, {A, B}) ->
                                        {B, (A * 2 + B * 3) rem 1000000007}
                                    end, {6, 12}, lists:seq(2, N)),
            B.