-module(find_and_replace_in_string).
-export([find_replace_string/3]).

find_replace_string(S, Indices, Sources, Targets) ->
    find_replace_string(S, Indices, Sources, Targets, []).

find_replace_string(S, [], [], [], Acc) ->
    lists:reverse(Acc) ++ S;
find_replace_string(S, [Index | RestIndices], [Source | RestSources], [Target | RestTargets], Acc) ->
    Len = length(Source),
    Sub = string:substr(S, Index + 1, Len),
    if
        Sub == Source ->
            find_replace_string(string:substr(S, Index + Len + 1, length(S) - (Index + Len)), RestIndices, RestSources, RestTargets, lists:reverse(string:substr(S, 1, Index) ++ Target) ++ Acc);
        true ->
            find_replace_string(S, RestIndices, RestSources, RestTargets, Acc)
    end.