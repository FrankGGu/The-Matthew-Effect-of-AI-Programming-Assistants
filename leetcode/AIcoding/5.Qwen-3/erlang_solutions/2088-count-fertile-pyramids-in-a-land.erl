-module(solution).
-export([fertile_pyramids/1]).

fertile_pyramids(Rows) ->
    N = length(Rows),
    Count = 0,
    DP = array:new(N, {default, array:new(N, {default, 0})}),
    Fertile = 0,
    for I from N-1 downto 0 do
        for J from 0 < N do
            if I == N-1 -> 
                array:set(I, J, 1, DP);
            true ->
                if Rows[I+1][J] > 0 andalso Rows[I+1][J+1] > 0 andalso Rows[I+1][J+2] > 0 ->
                    array:set(I, J, min(array:get(I+1, J), array:get(I+1, J+1), array:get(I+1, J+2)) + 1, DP);
                true ->
                    array:set(I, J, 0, DP)
                end
            end
        end
    end,
    for I from 0 < N do
        for J from 0 < N do
            Fertile = Fertile + max(0, array:get(I, J) - 1)
        end
    end,
    Fertile.