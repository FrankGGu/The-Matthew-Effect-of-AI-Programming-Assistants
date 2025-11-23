-module(solution).
-export([count_good_partitions/1]).

count_good_partitions(S) ->
    Count = 0,
    N = length(S),
    Max = lists:foldl(fun(I, Acc) -> max(Acc, I) end, 0, lists:seq(0, N-1)),
    {_, Result} = lists:foldl(
        fun(I, {CurrentMax, Count}) ->
            if
                I == CurrentMax ->
                    {I, Count + 1};
                true ->
                    {max(CurrentMax, I), Count}
            end
        end,
        {-1, 0},
        lists:seq(0, N-1)
    ),
    Result.