-module(rearrange_k_substrings).
-export([can_rearrange/2]).

can_rearrange(Constraints, Target) ->
    can_rearrange(Constraints, Target, 0, 0).

can_rearrange([], _, _, _) -> true;
can_rearrange(_, [], _, _) -> false;
can_rearrange([H|T], Target, Index, Count) ->
    case string:substr(Target, Index+1, length(H)) of
        H ->
            can_rearrange(T, Target, Index + length(H), Count + 1);
        _ ->
            can_rearrange(T, Target, Index, Count)
    end.