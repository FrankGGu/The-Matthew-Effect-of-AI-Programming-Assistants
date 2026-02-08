-module(solution).
-export([find_maximum_number_of_elements/1]).

find_maximum_number_of_elements(Nums) ->
    Counts = lists:foldl(
        fun(Num, Acc) ->
            maps:update_with(Num, fun(Count) -> Count + 1 end, 1, Acc)
        end,
        #{},
        Nums
    ),
    find_maximum_number_of_elements_helper(Counts, 0).

find_maximum_number_of_elements_helper(Counts, MaxLength) ->
    case maps:is_key(1, Counts) of
        true ->
            OneCount = maps:get(1, Counts),
            find_maximum_number_of_elements_recursive(Counts, 1, OneCount, OneCount, MaxLength);
        false ->
            MaxLength
    end.

find_maximum_number_of_elements_recursive(Counts, Num, CurrentLength, OneCount, MaxLength) ->
    NextNum = Num * Num,
    case maps:is_key(NextNum, Counts) of
        true ->
            NextCount = maps:get(NextNum, Counts),
            case NextCount > 1 of
                true ->
                    find_maximum_number_of_elements_recursive(Counts, NextNum, CurrentLength + 2, OneCount, Max(MaxLength, CurrentLength + 2));
                false ->
                    find_maximum_number_of_elements_recursive(Counts, NextNum, CurrentLength + 1, OneCount, Max(MaxLength, CurrentLength + 1))
            end;
        false ->
            Max(MaxLength, CurrentLength)
    end.

Max(A, B) ->
    if A > B -> A; true -> B end.