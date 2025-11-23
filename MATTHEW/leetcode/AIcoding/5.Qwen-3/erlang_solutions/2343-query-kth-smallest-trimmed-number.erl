-module(solution).
-export([kth_smallest/2]).

kth_smallest(Numbers, K) ->
    Sorted = lists:sort(fun(A, B) -> 
        {A, B} = {lists:sublist(A, 1), lists:sublist(B, 1)}, 
        case A of
            [X] when X < B -> true;
            _ -> false
        end
    end, Numbers),
    lists:nth(K, Sorted).