-module(divide_string).
-export([divide_string/3]).

divide_string(S, K, Fill) ->
    Len = length(S),
    NumGroups = (Len + K - 1) div K,
    lists:map(fun(I) ->
                      StartIndex = (I - 1) * K,
                      EndIndex = min(StartIndex + K - 1, Len - 1),
                      Group = lists:sublist(S, StartIndex + 1, EndIndex - StartIndex + 1),
                      pad_string(Group, K, Fill)
              end, lists:seq(1, NumGroups)).

pad_string(Group, K, Fill) ->
    Len = length(Group),
    if Len < K ->
        Group ++ lists:duplicate(K - Len, Fill)
    else
        Group
    end.