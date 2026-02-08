-module(partition_array_into_three_parts_with_equal_sum).
-export([canThreePartsEnough/1]).

canThreePartsEnough(A) ->
    Sum = lists:sum(A),
    case Sum rem 3 of
        0 ->
            Target = Sum div 3,
            canThreePartsEnough(A, Target, 0, 0);
        _ ->
            false
    end.

canThreePartsEnough([], _, _, 3) -> true;
canThreePartsEnough([], _, _, _) -> false;
canThreePartsEnough([H | T], Target, Count, CurrentSum) ->
    NewCurrent = CurrentSum + H,
    if
        NewCurrent == Target andalso Count < 2 ->
            canThreePartsEnough(T, Target, Count + 1, 0);
        NewCurrent == Target andalso Count == 2 ->
            canThreePartsEnough(T, Target, Count + 1, 0);
        true ->
            canThreePartsEnough(T, Target, Count, NewCurrent)
    end.