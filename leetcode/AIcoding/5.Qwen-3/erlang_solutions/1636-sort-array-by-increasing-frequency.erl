-module(solution).
-export([frequency_sort/1]).

frequency_sort(Nums) ->
    Count = count_frequencies(Nums),
    Sorted = lists:sort(fun({A, X}, {B, Y}) -> 
                            if X < Y -> true;
                               X == Y -> A < B;
                               true -> false
                            end
                        end, Count),
    lists:flatmap(fun({N, _}) -> [N] end, Sorted).

count_frequencies(Nums) ->
    count_frequencies(Nums, #{}).

count_frequencies([], Acc) ->
    maps:to_list(Acc);
count_frequencies([N | Rest], Acc) ->
    NewAcc = case maps:find(N, Acc) of
                 {ok, V} -> maps:update(N, V + 1, Acc);
                 error -> maps:put(N, 1, Acc)
             end,
    count_frequencies(Rest, NewAcc).