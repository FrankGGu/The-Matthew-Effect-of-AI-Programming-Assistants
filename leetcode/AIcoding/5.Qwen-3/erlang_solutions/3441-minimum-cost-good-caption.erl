-module(minimum_cost_good_caption).
-export([min_cost/2]).

min_cost(Prices, S) ->
    N = length(Prices),
    M = length(S),
    {_, Cost} = lists:foldl(fun(I, {Pos, Acc}) ->
        case Pos < M of
            true ->
                case S -- [lists:nth(Pos + 1, S)] of
                    [] -> {Pos + 1, Acc};
                    _ -> {Pos, Acc + lists:nth(I, Prices)}
                end;
            false ->
                {Pos, Acc + lists:nth(I, Prices)}
        end
    end, {0, 0}, lists:seq(1, N)),

    Cost.