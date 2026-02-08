-module(solution).
-export([is_split_possible/1]).

is_split_possible(S) ->
    LenS = length(S),
    lists:any(fun(FirstNumLen) ->
        {FirstNumStr, RestS} = lists:split(FirstNumLen, S),
        FirstNum = list_to_integer(FirstNumStr),
        dfs(RestS, FirstNum, 1)
    end, lists:seq(1, LenS - 1)).

dfs(RemainingString, PrevNum, Count) ->
    if RemainingString == [] ->
        Count >= 2;
    true ->
        LenRemaining = length(RemainingString),
        lists:any(fun(CurrentNumLen) ->
            {CurrentNumStr, RestOfRemaining} = lists:split(CurrentNumLen, RemainingString),
            CurrentNum = list_to_integer(CurrentNumStr),
            if CurrentNum == PrevNum - 1 ->
                dfs(RestOfRemaining, CurrentNum, Count + 1);
               true ->
                false
            end
        end, lists:seq(1, LenRemaining))
    end.