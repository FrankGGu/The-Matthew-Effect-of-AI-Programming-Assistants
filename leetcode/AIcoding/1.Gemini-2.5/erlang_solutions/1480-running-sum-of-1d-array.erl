-module(solution).
-export([running_sum/1]).

running_sum(Nums) ->
    {_FinalSum, ReversedResult} = lists:foldl(
        fun(X, {CurrentSum, AccList}) ->
            NewSum = CurrentSum + X,
            {NewSum, [NewSum | AccList]}
        end,
        {0, []},
        Nums
    ),
    lists:reverse(ReversedResult).