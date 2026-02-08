-module(can_convert_string_in_k_moves).
-export([canConvertString/2]).

canConvertString(S, K) ->
    Len = length(S),
    Count = lists:foldl(fun(Char, Acc) -> maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc) end, #{}, S),
    MaxShift = K,
    case lists:all(fun({_, V}) -> V =< 1 end, maps:to_list(Count)) of
        true -> true;
        false ->
            Shifts = maps:values(Count),
            SortedShifts = lists:sort(fun(A, B) -> A > B end, Shifts),
            lists:all(fun(Shift) -> (Shift - 1) * 25 =< MaxShift end, SortedShifts)
    end.