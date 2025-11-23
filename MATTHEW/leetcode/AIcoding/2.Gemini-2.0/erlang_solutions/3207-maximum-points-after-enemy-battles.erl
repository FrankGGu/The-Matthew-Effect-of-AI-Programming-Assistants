-module(maximum_points_after_enemy_battles).
-export([max_points/2]).

max_points(E, P) ->
    max_points(E, P, length(E), 0, 0, []).

max_points(_, _, 0, Points, _, Memo) ->
    {Points, Memo};
max_points(E, P, I, Points, Selected, Memo) ->
    case lists:member({I, Selected}, Memo) of
        true ->
            {Points, Memo};
        false ->
            {Points1, Memo1} = max_points(E, P, I - 1, Points, 0, Memo),
            {Points2, Memo2} = max_points(E, P, I - 1, Points + lists:nth(I, E) - P, 1, Memo),
            case Points1 > Points2 of
                true ->
                    {Points1, [{I, Selected} | Memo1]};
                false ->
                    {Points2, [{I, Selected} | Memo2]}
            end
    end.

max_points(E, P) ->
    N = length(E),
    Memo = array:new(N+1, {undefined, undefined}),
    max_points_helper(E, P, N, 0, Memo).

max_points_helper(_, _, 0, Points, _) ->
    Points;
max_points_helper(E, P, I, Points, Memo) ->
    case array:get(I, Memo) of
        {undefined, undefined} ->
            Points1 = max_points_helper(E, P, I - 1, Points, Memo),
            Points2 = max_points_helper(E, P, I - 1, Points + lists:nth(I, E) - P, Memo),
            case Points1 > Points2 of
                true ->
                    array:set(I, {Points1, 0}, Memo),
                    Points1;
                false ->
                    array:set(I, {Points2, 1}, Memo),
                    Points2
            end;
        {Val, _} ->
            Val
    end.

max_points(E, P) ->
    N = length(E),
    DP = array:new(N+1, 0),

    array:set(0, 0, DP),

    lists:foreach(fun(I) ->
                       Points1 = array:get(I-1, DP),
                       Points2 = array:get(I-1, DP) + lists:nth(I, E) - P,
                       case Points1 > Points2 of
                           true ->
                               array:set(I, Points1, DP);
                           false ->
                               array:set(I, Points2, DP)
                       end
                   end, lists:seq(1, N)),
    array:get(N, DP).