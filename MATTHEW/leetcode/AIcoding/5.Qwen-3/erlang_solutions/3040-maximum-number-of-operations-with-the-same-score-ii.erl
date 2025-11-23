-module(solution).
-export([max_operations/1]).

max_operations(Nums) ->
    max_operations(Nums, 0, 0, 0, 0).

max_operations([], _, _, _, _) ->
    0;
max_operations([H | T], Count, First, Second, Total) ->
    if
        Count == 0 ->
            max_operations(T, 1, H, 0, 0);
        Count == 1 ->
            max_operations(T, 2, First, H, First + H);
        true ->
            case (First + Second) of
                Sum when Sum == Total ->
                    max_operations(T, Count + 1, Second, H, Total);
                _ ->
                    max_operations(T, Count, Second, H, Total)
            end
    end.