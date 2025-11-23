-module(reverse_subarray).
-export([max_value_after_reverse/1]).

max_value_after_reverse(Nums) ->
    N = length(Nums),
    case N of
        0 -> 0;
        1 -> 0;
        _ ->
            Value = array_value(Nums),
            MaxChange = max_change(Nums),
            Value + MaxChange
    end.

array_value(Nums) ->
    lists:foldl(fun(X, {Prev, Acc}) ->
                        case Prev of
                            undefined -> {X, Acc};
                            _ -> {X, Acc + abs(X - Prev)}
                        end
                end, {undefined, 0}, Nums),
    {_, Value} = lists:foldl(fun(X, {Prev, Acc}) ->
                        case Prev of
                            undefined -> {X, Acc};
                            _ -> {X, Acc + abs(X - Prev)}
                        end
                end, {undefined, 0}, Nums),
    Value.

max_change(Nums) ->
    N = length(Nums),
    First = lists:nth(1, Nums),
    Last = lists:nth(N, Nums),
    MaxChange1 = max_change_first_last(Nums, First, Last),
    MaxChange2 = max_change_middle(Nums),
    max(MaxChange1, MaxChange2).

max_change_first_last(Nums, First, Last) ->
    N = length(Nums),
    MaxFirst = lists:foldl(fun(I, Acc) ->
                                case I of
                                    1 -> Acc;
                                    _ ->
                                        Num = lists:nth(I, Nums),
                                        max(Acc, 2 * (max(abs(First - Num), abs(Last - lists:nth(I - 1, Nums))) - (abs(Num - lists:nth(I - 1, Nums)))))
                                end
                            end, 0, lists:seq(1, N)),
    MaxFirst.

max_change_middle(Nums) ->
    N = length(Nums),
    lists:foldl(fun(I, Acc) ->
                        case I of
                            1 -> Acc;
                            N -> Acc;
                            _ ->
                                Num = lists:nth(I, Nums),
                                Prev = lists:nth(I - 1, Nums),
                                Next = lists:nth(I + 1, Nums),
                                Acc1 = abs(Next - Prev) - abs(Num - Prev) - abs(Num - Next),
                                max(Acc, Acc1)
                        end
                end, 0, lists:seq(2, N - 1)).

max(A, B) ->
    if A > B -> A;
       true -> B
    end.