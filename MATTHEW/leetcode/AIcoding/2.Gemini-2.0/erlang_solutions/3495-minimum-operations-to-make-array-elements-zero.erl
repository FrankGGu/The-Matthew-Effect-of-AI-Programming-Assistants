-module(min_operations).
-export([minimum_operations/1]).

minimum_operations(Nums) ->
    minimum_operations(Nums, sets:new(), 0).

minimum_operations([], Set, Count) ->
    Count;
minimum_operations([H|T], Set, Count) ->
    case H > 0 of
        true ->
            case sets:is_element(H, Set) of
                true ->
                    minimum_operations(T, Set, Count);
                false ->
                    NewSet = sets:add_element(H, Set),
                    NewNums = [max(0, N - H) || N <- [H|T]],
                    minimum_operations(NewNums, NewSet, Count + 1);
                false ->
                    minimum_operations(T, Set, Count)
            end;
        false ->
            minimum_operations(T, Set, Count)
    end.