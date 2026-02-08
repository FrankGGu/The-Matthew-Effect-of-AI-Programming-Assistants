-module(minimum_sum_of_mountain_triplets_i).
-export([triplet/1]).

triplet(Nums) ->
    N = length(Nums),
    MinSum = infinity,
    lists:foreach(fun(I) ->
        lists:foreach(fun(J) ->
            if J > I+1 ->
                lists:foreach(fun(K) ->
                    if K > J ->
                        A = lists:nth(I+1, Nums),
                        B = lists:nth(J+1, Nums),
                        C = lists:nth(K+1, Nums),
                        if A < B andalso B > C ->
                            Sum = A + B + C,
                            if Sum < MinSum ->
                                erlang:put(min_sum, Sum);
                            true ->
                                ok
                            end;
                        true ->
                            ok
                        end;
                    true ->
                        ok
                    end
                end, lists:seq(J+1, N-1));
            true ->
                ok
            end
        end, lists:seq(I+1, N-1))
    end, lists:seq(0, N-3)),
    case erlang:get(min_sum) of
        infinity -> -1;
        S -> S
    end.