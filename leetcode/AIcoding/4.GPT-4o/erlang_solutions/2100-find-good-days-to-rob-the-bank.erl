-module(solution).
-export([good_days_to_rob_bank/2]).

good_days_to_rob_bank(security, time) ->
    N = length(security),
    lists:foldl(fun(X, {Acc, Prev}) ->
        case Prev of
            {_, 0} -> {Acc ++ [0], X};
            {Last, _} when X > Last -> {Acc, 0};
            {Last, Days} when X < Last -> {Acc, Days + 1};
            {Last, Days} -> {Acc, Days + 1}
        end
    end, {[], 0}, lists:reverse(security))
    |> elem(0)
    |> lists:filter(fun Day -> Day >= time end).