-module(solution).
-export([original_digits/1]).

original_digits(S) ->
    Count = lists:foldl(fun(C, Acc) -> 
                            maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) 
                        end, #{}, S),
    Zero = maps:get($z, Count, 0),
    Two = maps:get($w, Count, 0),
    Four = maps:get($u, Count, 0),
    Six = maps:get($x, Count, 0),
    Eight = maps:get($g, Count, 0),
    Three = maps:get($h, Count, 0) - Eight,
    Five = maps:get($f, Count, 0) - Four,
    Seven = maps:get($s, Count, 0) - Six,
    One = maps:get($o, Count, 0) - Zero - Two - Four,
    Nine = (maps:get($i, Count, 0) - Five - Six - Eight),
    Digits = [
        {0, Zero},
        {1, One},
        {2, Two},
        {3, Three},
        {4, Four},
        {5, Five},
        {6, Six},
        {7, Seven},
        {8, Eight},
        {9, Nine}
    ],
    Sorted = lists:sort(fun({A, _}, {B, _}) -> A =< B end, Digits),
    Result = lists:foldl(fun({D, C}, Acc) -> 
                            lists:duplicate(C, $0 + D) ++ Acc 
                         end, [], Sorted),
    lists:reverse(Result).