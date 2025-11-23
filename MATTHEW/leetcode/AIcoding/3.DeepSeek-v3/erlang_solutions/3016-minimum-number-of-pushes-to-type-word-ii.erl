-module(solution).
-export([minimum_pushes/1]).

minimum_pushes(Word) ->
    Freq = lists:foldl(fun(C, Acc) -> 
                           maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
                       end, #{}, Word),
    Sorted = lists:reverse(lists:sort(maps:values(Freq))),
    calculate_pushes(Sorted, 0, 1, 0).

calculate_pushes([], _, _, Total) -> Total;
calculate_pushes([H|T], Count, Push, Total) ->
    if 
        Count < 8 -> 
            calculate_pushes(T, Count + 1, Push, Total + H * Push);
        true -> 
            calculate_pushes(T, 1, Push + 1, Total + H * Push)
    end.