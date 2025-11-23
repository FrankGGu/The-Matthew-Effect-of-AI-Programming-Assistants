-module(solution).
-export([find_integer/1]).

find_integer(Nums) ->
    find_integer_helper(Nums, 0, 0).

find_integer_helper([], 0, _Sum) -> 
    0;
find_integer_helper([H | T], Count, Sum) ->
    NewCount = Count + H,
    NewSum = Sum + H,
    case NewCount of
        0 -> 
            NewSum + find_integer_helper(T, NewCount, NewSum);
        _ -> 
            find_integer_helper(T, NewCount, NewSum)
    end.