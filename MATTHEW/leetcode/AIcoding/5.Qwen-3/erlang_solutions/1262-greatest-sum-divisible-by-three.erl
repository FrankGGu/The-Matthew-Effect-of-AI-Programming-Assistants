-module(greatest_sum_divisible_by_three).
-export([max_sum_divisible_by_three/1]).

max_sum_divisible_by_three(Nums) ->
    lists:foldl(fun(N, Acc) -> [N | Acc] end, [], Nums),
    max_sum_divisible_by_three(lists:reverse(Nums), 0, 0, 0).

max_sum_divisible_by_three([], A, B, C) ->
    case A rem 3 of
        0 -> A;
        _ -> 
            case B rem 3 of
                0 -> B;
                _ -> C
            end
    end;

max_sum_divisible_by_three([H | T], A, B, C) ->
    NewA = A + H,
    NewB = B + H,
    NewC = C + H,
    case NewA rem 3 of
        0 -> max_sum_divisible_by_three(T, NewA, B, C);
        1 -> max_sum_divisible_by_three(T, A, NewB, C);
        2 -> max_sum_divisible_by_three(T, A, B, NewC)
    end.