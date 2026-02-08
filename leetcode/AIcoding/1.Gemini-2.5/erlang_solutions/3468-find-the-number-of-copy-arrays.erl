-module(solution).
-export([find_number_of_copy_arrays/1]).

find_number_of_copy_arrays(ListOfArrays) ->
    Frequencies = lists:foldl(
        fun(Array, AccMap) ->
            maps:update_with(Array, fun(Count) -> Count + 1 end, 1, AccMap)
        end,
        #{},
        ListOfArrays
    ),
    lists:foldl(
        fun({_Array, Count}, AccCopies) ->
            if
                Count > 1 -> AccCopies + (Count - 1);
                true -> AccCopies
            end
        end,
        0,
        maps:to_list(Frequencies)
    ).