-module(number_of_ways_to_separate_numbers).
-export([num_ways/1]).

num_ways(S) ->
    N = length(S),
    DP = array:new(N+1, {default, 0}),
    array:set(0, 1, DP),
    Max = 1000000007,
    Num = fun(I) -> list_to_integer(string:substr(S, 1, I)) end,
    Ways = fun(I, J) ->
        case J > I of
            true -> 0;
            false ->
                Val = array:get(J, DP),
                if Val == 0 -> 0;
                   true -> (Val * 10 + Num(I - J)) rem Max
                end
        end
    end,
    lists:foreach(fun(I) ->
        lists:foreach(fun(J) ->
            if J > I -> ok;
               true ->
                    V = Ways(I, J),
                    array:set(I, (array:get(I, DP) + V) rem Max, DP)
            end
        end, lists:seq(1, I))
    end, lists:seq(1, N)),
    array:get(N, DP).