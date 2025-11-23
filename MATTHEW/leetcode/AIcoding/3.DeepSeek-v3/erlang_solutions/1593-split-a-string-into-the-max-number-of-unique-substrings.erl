-module(solution).
-export([max_unique_split/1]).

max_unique_split(S) ->
    max_unique_split(S, sets:new(), 0).

max_unique_split([], _, Count) ->
    Count;
max_unique_split(S, Set, Count) ->
    lists:foldl(fun(I, Max) ->
        Substring = string:substr(S, 1, I),
        case sets:is_element(Substring, Set) of
            false ->
                NewSet = sets:add_element(Substring, Set),
                Current = max_unique_split(string:substr(S, I + 1), NewSet, Count + 1),
                max(Max, Current);
            true ->
                Max
        end
    end, 0, lists:seq(1, length(S))).