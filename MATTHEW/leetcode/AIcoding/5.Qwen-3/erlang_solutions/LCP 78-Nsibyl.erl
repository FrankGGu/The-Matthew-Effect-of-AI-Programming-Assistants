-module(solution).
-export([find_wall/1]).

find_wall(Nums) ->
    find_wall(Nums, 0, 0).

find_wall([], _, Result) ->
    Result;
find_wall([H | T], Index, Result) ->
    case H of
        0 -> find_wall(T, Index + 1, Result);
        _ -> 
            Count = Index - Result,
            if
                Count > 0 -> find_wall(T, Index + 1, Result + 1);
                true -> find_wall(T, Index + 1, Result)
            end
    end.