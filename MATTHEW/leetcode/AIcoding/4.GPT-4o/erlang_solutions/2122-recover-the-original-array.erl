-module(solution).
-export([recover_original_array/1]).

recover_original_array(D) ->
    Sorted = lists:sort(D),
    recover(Sorted, []).

recover([], Acc) -> 
    lists:reverse(Acc);
recover([H | T], Acc) ->
    case lists:member(H * 2, T) of
        true ->
            recover(lists:delete(H * 2, T), [H | Acc]);
        false ->
            []
    end.