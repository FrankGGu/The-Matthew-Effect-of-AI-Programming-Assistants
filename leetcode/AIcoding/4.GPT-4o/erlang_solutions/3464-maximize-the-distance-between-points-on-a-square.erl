-module(solution).
-export([max_distance/2]).

max_distance(N, M) ->
    case N rem 2 of
        0 -> 
            case M rem 2 of
                0 -> N + M;
                _ -> N + M - 1
            end;
        _ ->
            case M rem 2 of
                0 -> N + M - 1;
                _ -> N + M - 2
            end
    end.