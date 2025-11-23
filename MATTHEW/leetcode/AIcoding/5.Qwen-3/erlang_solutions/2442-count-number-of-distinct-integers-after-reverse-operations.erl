-module(solution).
-export([count_distinct_integers/1]).

count_distinct_integers(Numbers) ->
    ReverseSet = lists:foldl(fun(Number, Acc) ->
        Reverse = reverse_number(Number),
        sets:insert(Reverse, Acc)
    end, sets:new(), Numbers),
    sets:size(ReverseSet).

reverse_number(N) ->
    reverse_number(N, 0).

reverse_number(0, Rev) ->
    Rev;
reverse_number(N, Rev) ->
    reverse_number(N div 10, Rev * 10 + N rem 10).