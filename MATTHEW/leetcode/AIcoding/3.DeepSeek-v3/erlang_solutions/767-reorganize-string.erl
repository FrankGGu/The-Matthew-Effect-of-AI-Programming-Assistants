-module(reorganize_string).
-export([reorganize_string/1]).

reorganize_string(S) ->
    Freq = lists:foldl(fun(Char, Acc) ->
                            maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                        end, #{}, S),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A >= B end, maps:to_list(Freq)),
    case lists:nth(1, Sorted) of
        {_, Max} when Max > (length(S) + 1) div 2 ->
            "";
        _ ->
            reorganize(Sorted, length(S), [])
    end.

reorganize([], _, Result) ->
    lists:reverse(Result);
reorganize([{Char, Count} | Rest], Len, Result) ->
    reorganize(Rest ++ case Count - 1 > 0 of true -> [{Char, Count - 1}]; false -> [] end, Len - 1, [Char | Result]).