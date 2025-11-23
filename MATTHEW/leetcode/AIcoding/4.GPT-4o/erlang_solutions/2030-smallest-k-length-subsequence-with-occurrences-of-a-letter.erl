-module(solution).
-export([smallest_subsequence/3]).

smallest_subsequence(S, K, L) ->
    Length = string:len(S),
    Occurrences = lists:foldl(fun(X, Acc) -> case lists:keyfind(X, 1, Acc) of
        false -> [{X, 1} | Acc];
        {X, Count} -> [{X, Count + 1} | lists:keydelete(X, 1, Acc)]
    end end, [], S),
    smallest_subsequence_helper(S, K, L, Occurrences, Length, []).

smallest_subsequence_helper(_, 0, _, _, _, Acc) -> lists:reverse(Acc);
smallest_subsequence_helper(S, K, L, Occurrences, Length, Acc) ->
    {MinChar, _} = lists:min(Occurrences),
    NewOccurrences = lists:keydelete(MinChar, 1, Occurrences),
    NextStr = string:to_list(S),
    {NewStr, NewCount} = remove_char(NextStr, MinChar, 1),
    if NewCount > 0 orelse string:len(NewStr) >= K ->
        smallest_subsequence_helper(list_to_string(NewStr), K - 1, L, NewOccurrences, Length - 1, [MinChar | Acc]);
    true -> smallest_subsequence_helper(list_to_string(NewStr), K, L, NewOccurrences, Length - 1, Acc)
    end.

remove_char([], _, _) -> {[], 0};
remove_char([H | T], C, Count) ->
    if H == C -> 
        {NewT, NewCount} = remove_char(T, C, Count + 1),
        {NewT, NewCount};
    true -> 
        {T, Count}
    end.