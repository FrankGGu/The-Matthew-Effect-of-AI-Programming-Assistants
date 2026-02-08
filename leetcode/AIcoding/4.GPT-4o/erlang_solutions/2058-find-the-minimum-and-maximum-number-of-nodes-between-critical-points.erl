-module(solution).
-export([nodes_between_critical_points/1]).

nodes_between_critical_points(List) ->
    CriticalPoints = find_critical_points(List),
    case length(CriticalPoints) of
        0 -> {-1, -1};
        1 -> {0, 0};
        _ -> {min_distance(CriticalPoints), max_distance(CriticalPoints)}
    end.

find_critical_points([]) -> [];
find_critical_points([_]) -> [];
find_critical_points([_ | [_]]) -> [];
find_critical_points([H, M, L | T]) ->
    case (H < M andalso M > L) orelse (H > M andalso M < L) of
        true -> [1 | find_critical_points([M | T])];
        false -> find_critical_points([M | T])
    end.

min_distance(CriticalPoints) ->
    MinDist = lists:foldl(fun(X, Acc) -> 
        case Acc of 
            {Prev, Min} -> 
                case Prev of 
                    -1 -> {X, Min}; 
                    _ -> {X, min(Min, X - Prev)} 
                end 
        end 
    end, {-1, infinity}, CriticalPoints),
    case MinDist of 
        {_, Min} -> if 
            Min == infinity -> -1; 
            true -> Min 
        end 
    end.

max_distance(CriticalPoints) ->
    MaxDist = lists:last(CriticalPoints) - lists:hd(CriticalPoints),
    MaxDist.