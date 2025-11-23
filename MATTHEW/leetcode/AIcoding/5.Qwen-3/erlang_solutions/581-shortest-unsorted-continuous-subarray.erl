-module(solution).
-export([find_unsorted_subarray/1]).

find_unsorted_subarray(Nums) ->
    find_unsorted_subarray(Nums, 0, length(Nums) - 1, 0, length(Nums) - 1).

find_unsorted_subarray(Nums, Left, Right, Start, End) ->
    case Left > Right of
        true -> End - Start + 1;
        false ->
            case lists:nth(Left + 1, Nums) >= lists:nth(Left, Nums) of
                true -> find_unsorted_subarray(Nums, Left + 1, Right, Start, End);
                false ->
                    case lists:nth(Right, Nums) <= lists:nth(Right + 1, Nums) of
                        true -> find_unsorted_subarray(Nums, Left, Right - 1, Start, End);
                        false ->
                            NewStart = if Start == 0 -> Left; true -> Start end,
                            NewEnd = if End == length(Nums) - 1 -> Right; true -> End end,
                            find_unsorted_subarray(Nums, Left + 1, Right - 1, NewStart, NewEnd)
                    end
            end
    end.