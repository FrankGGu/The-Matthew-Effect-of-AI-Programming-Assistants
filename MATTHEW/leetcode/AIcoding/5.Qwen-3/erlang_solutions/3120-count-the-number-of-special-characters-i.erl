-module(solution).
-export([solve/1]).

solve(Chars) ->
    Count = lists:foldl(fun(Char, Acc) -> 
        case is_special(Char, Chars) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Chars).

is_special(Char, Chars) ->
    Count = lists:count(Char, Chars),
    lists:member(Char, [?A, ?B, ?C, ?D, ?E, ?F, ?G, ?H, ?I, ?J, ?K, ?L, ?M, ?N, ?O, ?P, ?Q, ?R, ?S, ?T, ?U, ?V, ?W, ?X, ?Y, ?Z]) andalso Count == 1.