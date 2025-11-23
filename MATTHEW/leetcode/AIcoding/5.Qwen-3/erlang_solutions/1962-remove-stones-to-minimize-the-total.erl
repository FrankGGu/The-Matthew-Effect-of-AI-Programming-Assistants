-module(solution).
-export([remove_stones/2]).

remove_stones(Stones, k) ->
    List = lists:sort(Stones),
    remove_stones(List, k, 0).

remove_stones([], _, Total) ->
    Total;
remove_stones([H | T], K, Total) ->
    if
        K > 0 ->
            NewH = H - (H div 2),
            remove_stones([NewH | T], K - 1, Total + (H - NewH));
        true ->
            remove_stones(T, K, Total + H)
    end.