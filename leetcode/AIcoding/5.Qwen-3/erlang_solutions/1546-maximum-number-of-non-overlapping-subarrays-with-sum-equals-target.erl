-module(max_non_overlapping_subarrays).
-export([max_number/1]).

max_number(Nums) ->
    max_number(Nums, 0, 0, sets:new(), 0).

max_number([], _, _, _, Acc) ->
    Acc;
max_number([H | T], Start, CurrentSum, Seen, Acc) ->
    CurrentSum2 = CurrentSum + H,
    if
        CurrentSum2 == 0 ->
            max_number(T, 0, 0, sets:add_element(H, Seen), Acc + 1);
        true ->
            case sets:is_element(CurrentSum2, Seen) of
                true ->
                    max_number(T, 0, 0, sets:add_element(H, Seen), Acc + 1);
                false ->
                    max_number(T, Start + 1, CurrentSum2, sets:add_element(CurrentSum2, Seen), Acc)
            end
    end.