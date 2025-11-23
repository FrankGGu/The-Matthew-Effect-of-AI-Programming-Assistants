-module(solution).
-export([is_possible/1]).

is_possible(S) ->
    Count = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) end, #{}, S),
    Keys = maps:keys(Count),
    Values = maps:values(Count),
    Min = lists:min(Values),
    Max = lists:max(Values),
    case Max - Min of
        0 -> true;
        _ ->
            case lists:member(Min, Values) andalso lists:member(Max, Values) of
                true ->
                    CountMin = lists:foldl(fun(V, Acc) -> if V == Min -> Acc + 1; true -> Acc end end, 0, Values),
                    CountMax = lists:foldl(fun(V, Acc) -> if V == Max -> Acc + 1; true -> Acc end end, 0, Values),
                    (CountMin == 1 andalso CountMax > 1) orelse (CountMax == 1 andalso CountMin > 1)
            end
    end.