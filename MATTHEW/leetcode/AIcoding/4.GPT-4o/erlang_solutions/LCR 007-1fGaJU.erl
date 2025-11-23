-module(solution).
-export([three_sum/1]).

three_sum(Nums) ->
    NumsSorted = lists:sort(Nums),
    three_sum_helper(NumsSorted, []).

three_sum_helper([], _) -> [];
three_sum_helper([H | T], Seen) ->
    Result = three_sum_with_fixed(H, T, -H, Seen),
    Result ++ three_sum_helper(T, [H | Seen]).

three_sum_with_fixed(_, [], _, _) -> [];
three_sum_with_fixed(Fixed, [H | T], Target, Seen) ->
    NewTarget = Target - H,
    case lists:member(NewTarget, T) of
        true ->
            [[Fixed, H, NewTarget] | three_sum_with_fixed(Fixed, T, Target, Seen)];
        false ->
            three_sum_with_fixed(Fixed, T, Target, Seen)
    end.