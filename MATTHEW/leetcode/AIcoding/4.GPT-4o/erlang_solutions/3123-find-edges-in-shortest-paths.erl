-module(solution).
-export([find_edges/3]).

find_edges(N, edges, queries) ->
    D = array:foldl(fun({X, Y, W}, Acc) ->
        array:foldl(fun(Z, Acc2) ->
            if
                array:get(X, Acc2) + W < array:get(Z, Acc2) ->
                    array:set(Z, array:get(X, Acc2) + W, Acc2);
                true ->
                    Acc2
            end
        end, Acc, [1,2,3,4,5,6,7,8,9,10]) % Adjust range based on N
    end, array:from_list(lists:duplicate(N, infinity)), edges),
    lists:map(fun({U, V}) -> 
        if array:get(U, D) + array:get(V, D) < infinity -> 
            true 
        else 
            false 
        end 
    end, queries).