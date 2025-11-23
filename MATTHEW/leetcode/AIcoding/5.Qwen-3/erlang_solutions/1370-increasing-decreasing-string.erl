-module(solution).
-export([sort_string/1]).

sort_string(S) ->
    Count = lists:foldl(fun(Char, Acc) -> dict:update_counter(Char, 1, Acc) end, dict:new(), S),
    Ascend = lists:usort(S),
    Descend = lists:reverse(Ascend),
    sort_string(Count, Ascend, Descend, []).

sort_string(_, [], [], Result) ->
    lists:flatten(Result);
sort_string(Count, Ascend, Descend, Result) ->
    NewResult = lists:foldl(fun(Char, Acc) ->
        case dict:is_key(Char, Count) of
            true ->
                Num = dict:fetch(Char, Count),
                if Num > 0 ->
                    Acc ++ [lists:duplicate(Num, Char)];
                   true ->
                    Acc
                end;
            false ->
                Acc
        end
    end, Result, Ascend ++ Descend),
    NewCount = lists:foldl(fun(Char, Acc) ->
        case dict:is_key(Char, Acc) of
            true ->
                dict:update_counter(Char, -1, Acc);
            false ->
                Acc
        end
    end, Count, Ascend ++ Descend),
    sort_string(NewCount, Ascend, Descend, NewResult).