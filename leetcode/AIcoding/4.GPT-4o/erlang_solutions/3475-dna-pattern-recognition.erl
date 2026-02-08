-module(solution).
-export([findRepeatedDnaSequences/1]).

findRepeatedDnaSequences(S) ->
    find_repeats(S, maps:new(), []).

find_repeats([], _, Acc) ->
    lists:reverse(Acc);
find_repeats(S, M, Acc) ->
    case lists:split(10, S) of
        {SubStr, []} -> 
            lists:reverse(Acc);
        {SubStr, _} -> 
            Str = lists:flatten(SubStr),
            NewM = maps:put(Str, maps:get(Str, M, 0) + 1, M),
            if
                maps:get(Str, NewM) == 2 ->
                    find_repeats(tl(S), NewM, [Str | Acc]);
                true ->
                    find_repeats(tl(S), NewM, Acc)
            end
    end.