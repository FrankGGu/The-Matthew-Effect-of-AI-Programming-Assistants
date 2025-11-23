-module(solution).
-export([can_partition/1]).

can_partition(Nums) ->
    Sum = lists:sum(Nums),
    if
        Sum rem 2 /= 0 -> false;
        true -> 
            Target = Sum div 2,
            dp(Target, Nums, 0, sets:new())
    end.

dp(_, [], _, _) -> true;
dp(Target, [H|T], Current, Seen) ->
    case sets:is_element(Current, Seen) of
        true -> dp(Target, T, Current, Seen);
        false ->
            NewSeen = sets:add_element(Current, Seen),
            case Current + H of
                C when C == Target -> true;
                C when C < Target -> dp(Target, T, C, NewSeen) orelse dp(Target, T, Current, NewSeen);
                _ -> dp(Target, T, Current, NewSeen)
            end
    end.