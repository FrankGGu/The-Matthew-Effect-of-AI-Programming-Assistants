-module(minimum_cost_to_reach_every_position).
-export([minCost/1]).

minCost(Cost) ->
    N = length(Cost),
    {Min1, Min2} = find_min_two(Cost),
    lists:map(fun(I) -> 
        if
            I == 0 -> Cost#{}; % 假设Cost是列表，这里需要调整
            true -> 
                if
                    I == 1 -> min(Cost#{}, Min1);
                    true -> min(Cost#{}, Min2)
                end
        end
    end, lists:seq(0, N-1)).

find_min_two(List) ->
    find_min_two(List, 999999, 999999).

find_min_two([], M1, M2) -> {M1, M2};
find_min_two([H|T], M1, M2) ->
    case H of
        V when V < M1 -> find_min_two(T, V, M1);
        V when V < M2 -> find_min_two(T, M1, V);
        _ -> find_min_two(T, M1, M2)
    end.