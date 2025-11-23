-module(solution).
-export([max_jumps/1]).

max_jumps(Nums) ->
    N = length(Nums),
    {-1, _} = lists:foldl(fun(I, {Max, DP}) ->
        case I of
            0 -> {0, [0 | DP]};
            _ ->
                MaxVal = lists:foldl(fun(J, Acc) ->
                    if J < I andalso (lists:nth(J + 1, Nums) < lists:nth(I + 1, Nums)) ->
                        max(Acc, lists:nth(J + 1, DP) + 1);
                       true -> Acc
                    end
                end, -1, lists:seq(0, I - 1)),
                {MaxVal, [MaxVal | DP]}
        end
    end, {-1, []}, lists:seq(0, N - 1)),
    lists:last(lists:reverse(lists:sublist(lists:reverse(lists:sublist(Nums, 1, N)), 1, N))).