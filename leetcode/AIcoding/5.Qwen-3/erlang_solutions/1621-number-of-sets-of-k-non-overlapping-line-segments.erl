-module(solution).
-export([number_of_sets/2]).

number_of_sets(Points, K) ->
    N = length(Points),
    DP = array:new([{size, N}, {default, 0}]),
    DP1 = array:set(0, 1, DP),
    lists:foreach(fun(I) -> 
        DP2 = array:set(I, 1, DP1),
        lists:foreach(fun(J) -> 
            if J < I ->
                Diff = abs(lists:nth(I+1, Points) - lists:nth(J+1, Points)),
                if Diff > 0 ->
                    DP3 = array:get(I, DP2),
                    DP4 = array:get(J, DP2),
                    NewVal = DP3 + DP4,
                    DP2 = array:set(I, NewVal, DP2);
                true -> ok
                end;
            true -> ok
            end
        end, lists:seq(0, I-1)),
        DP1 = DP2
    end, lists:seq(0, N-1)),
    array:get(N-1, DP1).