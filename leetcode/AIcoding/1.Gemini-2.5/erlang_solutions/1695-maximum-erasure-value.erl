-module(solution).
-export([max_erasure_value/1]).

max_erasure_value(Nums) ->
    solve(Nums, queue:new(), 0, 0, gb_sets:new()).

solve([], _WindowQ, _CurrentSum, MaxSum, _UniqueSet) ->
    MaxSum;
solve([H | T], WindowQ, CurrentSum, MaxSum, UniqueSet) ->
    case gb_sets:is_member(H, UniqueSet) of
        true ->
            {NewWindowQ, NewCurrentSum, NewUniqueSet} = shrink_window_q(WindowQ, H, CurrentSum, UniqueSet),
            UpdatedCurrentSum = NewCurrentSum + H,
            UpdatedUniqueSet = gb_sets:add_element(H, NewUniqueSet),
            UpdatedWindowQ = queue:in(H, NewWindowQ),
            solve(T, UpdatedWindowQ, UpdatedCurrentSum, erlang:max(MaxSum, UpdatedCurrentSum), UpdatedUniqueSet);
        false ->
            UpdatedCurrentSum = CurrentSum + H,
            UpdatedUniqueSet = gb_sets:add_element(H, UniqueSet),
            UpdatedWindowQ = queue:in(H, WindowQ),
            solve(T, UpdatedWindowQ, UpdatedCurrentSum, erlang:max(MaxSum, UpdatedCurrentSum), UpdatedUniqueSet)
    end.

shrink_window_q(WindowQ, TargetElement, CurrentSum, UniqueSet) ->
    {value, Head, TailQ} = queue:out(WindowQ),
    NewCurrentSum = CurrentSum - Head,
    NewUniqueSet = gb_sets:delete_element(Head, UniqueSet),
    if
        Head == TargetElement ->
            {TailQ, NewCurrentSum, NewUniqueSet};
        true ->
            shrink_window_q(TailQ, TargetElement, NewCurrentSum, NewUniqueSet)
    end.