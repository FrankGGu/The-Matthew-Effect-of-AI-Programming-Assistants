-module(solution).
-export([maximum_score/1]).

maximum_score(S) ->
    Count0 = lists:foldl(fun(X, {C0, C1}) ->
        case X of
            $0 -> {C0 + 1, C1};
            $1 -> {C0, C1 + 1}
        end
    end, {0, 0}, string:to_list(S)),
    maximum_score_helper(Count0, lists:reverse(string:to_list(S)), {0, 0}).

maximum_score_helper({C0, C1}, [], {Max, _}) ->
    Max;
maximum_score_helper({C0, C1}, [H | T], {Max, Count}) ->
    NewCounts = case H of
        $0 -> {C0 - 1, C1};
        $1 -> {C0, C1 - 1}
    end,
    NewMax = max(Max, Count + (C0 - elem(NewCounts, 0)) + (C1 - elem(NewCounts, 1))),
    maximum_score_helper(NewCounts, T, {NewMax, Count + (if H == $0 -> 1; true -> 0 end)}).