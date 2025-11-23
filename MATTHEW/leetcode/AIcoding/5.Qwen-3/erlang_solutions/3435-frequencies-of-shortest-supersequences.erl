-module(frequencies_of_shortest_supersequences).
-export([num_distinct_shortest_supersequences/2]).

num_distinct_shortest_supersequences(S, T) ->
    Count = maps:new(),
    {Count, _} = dfs(S, T, 0, 0, Count),
    maps:size(Count).

dfs([], _, _, _, Count) ->
    {Count, true};
dfs(_, [], _, _, Count) ->
    {Count, false};
dfs(S, T, I, J, Count) ->
    case maps:get({I, J}, Count, undefined) of
        undefined ->
            case lists:nth(I + 1, S) == lists:nth(J + 1, T) of
                true ->
                    {NewCount, Flag} = dfs(S, T, I + 1, J + 1, Count),
                    if
                        Flag ->
                            NewCount1 = maps:update({I, J}, 1, NewCount),
                            {NewCount1, true};
                        true ->
                            {NewCount, false}
                    end;
                false ->
                    {NewCount1, Flag1} = dfs(S, T, I + 1, J, Count),
                    {NewCount2, Flag2} = dfs(S, T, I, J + 1, Count),
                    if
                        Flag1 andalso Flag2 ->
                            Value = maps:get({I, J}, NewCount1, 0) + maps:get({I, J}, NewCount2, 0),
                            {maps:put({I, J}, Value, NewCount1), true};
                        Flag1 ->
                            {NewCount1, true};
                        Flag2 ->
                            {NewCount2, true};
                        true ->
                            {Count, false}
                    end
            end;
        _ ->
            {Count, true}
    end.