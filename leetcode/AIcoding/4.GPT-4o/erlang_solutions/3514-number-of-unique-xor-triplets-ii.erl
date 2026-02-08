-module(solution).
-export([count_unique_xor_triplets/1]).

count_unique_xor_triplets(Numbers) ->
    UniqueNumbers = lists:usort(Numbers),
    count_triplets(UniqueNumbers, 0).

count_triplets([], Count) -> 
    Count;
count_triplets([H|T], Count) ->
    Count1 = count_triplets(T, Count),
    Count2 = count_with_h(H, T, Count1),
    Count2.

count_with_h(_, [], Count) -> 
    Count;
count_with_h(H, [X|T], Count) ->
    NewCount = Count + lists:foldl(fun(Y, Acc) -> 
        if 
            H bxor X =:= Y -> 
                Acc + 1; 
            true -> 
                Acc 
        end 
    end, 0, T),
    count_with_h(H, T, NewCount).