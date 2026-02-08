-module(solution).
-export([max_rep_opt1/1]).

max_rep_opt1(S) ->
    Counts = lists:foldl(fun(C, Acc) -> 
                            maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, S),
    {MaxLen, CurrentLen, PrevLen, PrevChar} = lists:foldl(fun(C, {Max, Curr, PrevL, PrevC}) ->
        if
            C =:= PrevC ->
                NewCurr = Curr + 1,
                {max(Max, NewCurr), NewCurr, PrevL, PrevC};
            true ->
                NewPrevL = Curr,
                NewCurr = 1,
                NewMax = max(Max, NewCurr),
                {NewMax, NewCurr, NewPrevL, C}
        end
    end, {0, 0, 0, hd(S)}, S),
    lists:min([MaxLen + 1, maps:get(PrevChar, Counts, 0)]).