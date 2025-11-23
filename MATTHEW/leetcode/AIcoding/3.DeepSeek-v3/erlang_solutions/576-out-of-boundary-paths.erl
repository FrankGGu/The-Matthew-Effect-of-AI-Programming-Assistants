-module(solution).
-export([find_paths/3]).

find_paths(M, N, MaxMove) ->
    Mod = 1000000007,
    DP = array:new([{size, M}, {default, array:new([{size, N}, {default, 0}])}]),
    DP1 = update_dp(DP, M, N),
    lists:foldl(fun(_, Acc) -> 
        NewDP = update_dp(Acc, M, N),
        NewDP
    end, DP1, lists:seq(1, MaxMove - 1)),
    sum_dp(DP1, M, N, Mod).

update_dp(DP, M, N) ->
    NewDP = array:new([{size, M}, {default, array:new([{size, N}, {default, 0}])}]),
    lists:foldl(fun(I, AccI) ->
        Row = array:get(I, DP),
        NewRow = lists:foldl(fun(J, AccJ) ->
            case {I, J} of
                {0, _} -> 1;
                {_, 0} -> 1;
                {IM, _} when IM =:= M - 1 -> 1;
                {_, JN} when JN =:= N - 1 -> 1;
                _ ->
                    Val = (get_val(I - 1, J, DP) + get_val(I + 1, J, DP) + 
                           get_val(I, J - 1, DP) + get_val(I, J + 1, DP)) rem 1000000007,
                    Val
            end,
            array:set(J, Val, AccJ)
        end, array:new([{size, N}, {default, 0}]), lists:seq(0, N - 1)),
        array:set(I, NewRow, AccI)
    end, NewDP, lists:seq(0, M - 1)).

get_val(I, J, DP) ->
    case I >= 0 andalso I < array:size(DP) andalso J >= 0 andalso J < array:size(array:get(0, DP)) of
        true -> array:get(J, array:get(I, DP));
        false -> 0
    end.

sum_dp(DP, M, N, Mod) ->
    lists:foldl(fun(I, SumI) ->
        Row = array:get(I, DP),
        lists:foldl(fun(J, SumJ) ->
            case I =:= 0 orelse I =:= M - 1 orelse J =:= 0 orelse J =:= N - 1 of
                true -> (SumJ + array:get(J, Row)) rem Mod;
                false -> SumJ
            end
        end, SumI, lists:seq(0, N - 1))
    end, 0, lists:seq(0, M - 1)).