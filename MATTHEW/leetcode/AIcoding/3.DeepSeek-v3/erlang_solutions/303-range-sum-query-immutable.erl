-module(num_array).

-export([init/1, sum_range/3]).

init(Nums) ->
    {ok, lists:foldl(fun(X, {Sum, Acc}) -> {Sum + X, [Sum + X | Acc]} end, {0, []}, Nums)}.

sum_range(I, J, {ok, Sums}) ->
    Reversed = lists:reverse(Sums),
    case I of
        0 -> lists:nth(J + 1, Reversed);
        _ -> lists:nth(J + 1, Reversed) - lists:nth(I, Reversed)
    end.