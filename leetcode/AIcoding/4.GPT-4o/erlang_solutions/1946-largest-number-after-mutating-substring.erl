-module(solution).
-export([largest_number_after_mutating_substring/2]).

largest_number_after_mutating_substring(S, T) ->
    SList = string:to_list(S),
    TList = string:to_list(T),
    {MaxNum, _} = lists:foldl(fun(X, {MaxAcc, Index}) ->
        NewIndex = Index + 1,
        if 
            lists:nth(Index, TList) =< X -> 
                {MaxAcc, NewIndex}
            ; 
                {lists:replace_at(SList, Index - 1, lists:nth(Index, TList)), NewIndex}
        end
    end, {SList, 1}, lists:seq(1, length(SList))),
    list_to_binary(MaxNum).

replace_at(List, Index, NewElem) ->
    lists:take(Index - 1, List) ++ [NewElem] ++ lists:drop(Index, List).