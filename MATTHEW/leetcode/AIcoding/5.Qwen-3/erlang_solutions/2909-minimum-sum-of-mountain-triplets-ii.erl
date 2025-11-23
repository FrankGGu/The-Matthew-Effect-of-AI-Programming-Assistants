-module(minimum_sum_of_mountain_triplets_ii).
-export([tripletSum/1]).

tripletSum(Nums) ->
    N = length(Nums),
    Left = array:new(N, {default, 0}),
    Right = array:new(N, {default, 0}),
    I = 0,
    Min = 0,
    Max = 0,
    LeftValues = lists:seq(0, N-1),
    RightValues = lists:reverse(lists:seq(0, N-1)),
    LeftArray = arrays:foldl(fun(I, Acc) ->
        case I of
            0 -> array:set(I, 0, Acc);
            _ ->
                if
                    element(I, Nums) > element(I-1, Nums) ->
                        array:set(I, element(I-1, Left), Acc);
                    true ->
                        array:set(I, 0, Acc)
                end
        end
    end, Left, LeftValues),
    RightArray = arrays:foldl(fun(I, Acc) ->
        case I of
            N-1 -> array:set(I, 0, Acc);
            _ ->
                if
                    element(I, Nums) > element(I+1, Nums) ->
                        array:set(I, element(I+1, Right), Acc);
                    true ->
                        array:set(I, 0, Acc)
                end
        end
    end, Right, RightValues),
    Result = lists:foldl(fun(I, Acc) ->
        if
            element(I, LeftArray) > 0 andalso element(I, RightArray) > 0 ->
                Acc + element(I, Nums) + element(I, LeftArray) + element(I, RightArray);
            true ->
                Acc
        end
    end, 0, lists:seq(0, N-1)),
    Result.

element(Index, Array) ->
    array:get(Index, Array).

arrays:foldl(Fun, Acc, List) ->
    lists:foldl(Fun, Acc, List).