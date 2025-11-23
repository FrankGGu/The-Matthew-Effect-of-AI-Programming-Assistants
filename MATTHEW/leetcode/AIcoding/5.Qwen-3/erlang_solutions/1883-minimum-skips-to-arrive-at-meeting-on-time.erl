-module(solution).
-export([min_skips/2]).

min_skips(Paths, Target) ->
    N = length(Paths),
    Max = lists:foldl(fun({A, B}, Acc) -> max(A + B, Acc) end, 0, Paths),
    DP = array:new([{size, N + 1}, {default, array:new([{size, Max + 1}, {default, 1000000000}])}]),
    array:set(0, array:set(0, 0, array:get(0, DP)), DP),
    lists:foreach(fun(I) ->
        lists:foreach(fun(J) ->
            Val = array:get(I, DP),
            Current = array:get(J, Val),
            if Current =< 1000000000 ->
                Next = I + 1,
                {A, B} = lists:nth(I + 1, Paths),
                NewJ = J + A,
                if NewJ =< Max ->
                    NewVal = array:get(Next, DP),
                    array:set(NewJ, min(array:get(NewJ, NewVal), Current + B), NewVal);
                true ->
                    ok
            end
        end, lists:seq(0, Max)),
        lists:foreach(fun(J) ->
            Val = array:get(I, DP),
            Current = array:get(J, Val),
            if Current =< 1000000000 ->
                Next = I + 1,
                {A, B} = lists:nth(I + 1, Paths),
                NewJ = J + A,
                if NewJ =< Max ->
                    NewVal = array:get(Next, DP),
                    array:set(NewJ, min(array:get(NewJ, NewVal), Current + B), NewVal);
                true ->
                    ok
            end
        end, lists:seq(0, Max))
    end, lists:seq(0, N - 1)),
    lists:foldl(fun(J, Acc) ->
        if array:get(N, DP) =:= undefined -> Acc;
           true ->
               Val = array:get(J, array:get(n, DP)),
               if Val =< Target -> min(Acc, J);
                  true -> Acc
               end
        end
    end, 1000000000, lists:seq(0, Max)).