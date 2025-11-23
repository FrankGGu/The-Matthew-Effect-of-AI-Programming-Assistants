-module(single_element).
-export([single_non_duplicate/1]).

single_non_duplicate(Nums) ->
    single_non_duplicate(Nums, 0, length(Nums) - 1).

single_non_duplicate(Nums, Low, High) when Low > High ->
    undefined;
single_non_duplicate(Nums, Low, High) ->
    Mid = (Low + High) div 2,
    case Mid rem 2 of
        0 ->
            case Nums of
                [_,_|_] ->
                    if
                        Mid + 1 <= High andalso lists:nth(Mid + 1, Nums) == lists:nth(Mid + 1 + 1, Nums) ->
                            single_non_duplicate(Nums, Mid + 2, High);
                        Mid -1 >= Low andalso lists:nth(Mid + 1, Nums) == lists:nth(Mid, Nums) ->
                            single_non_duplicate(Nums, Mid + 2, High);
                        true ->
                            single_non_duplicate(Nums, Low, Mid - 1)
                    else
                        lists:nth(Mid+1, Nums)
                    end;
                [_] ->
                    lists:nth(Mid+1, Nums);
                [] -> undefined
            end;
        1 ->
            case Nums of
                [_,_|_] ->
                    if
                        lists:nth(Mid + 1, Nums) == lists:nth(Mid, Nums) ->
                            single_non_duplicate(Nums, Mid + 1, High);
                        true ->
                            single_non_duplicate(Nums, Low, Mid - 1)
                    else
                        lists:nth(Mid+1, Nums)
                    end;
                [_] ->
                    lists:nth(Mid+1, Nums);
                [] -> undefined
            end
    end.