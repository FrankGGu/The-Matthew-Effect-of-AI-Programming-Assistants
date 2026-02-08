-module(groups_of_strings).
-export([are_connected/2]).

are_connected(Word1, Word2) ->
    Count = lists:foldl(fun(C, Acc) -> Acc + case lists:member(C, Word2) of true -> 1; false -> 0 end end, 0, Word1),
    Count == length(Word1).

groups_of_strings(Groups) ->
    groups_of_strings(Groups, [], []).

groups_of_strings([], Result, _) ->
    Result;
groups_of_strings([Group | Rest], Result, Seen) ->
    case lists:member(Group, Seen) of
        true ->
            groups_of_strings(Rest, Result, Seen);
        false ->
            NewSeen = [Group | Seen],
            GroupList = [Group],
            NextGroups = lists:filter(fun(G) -> not lists:member(G, NewSeen) andalso are_connected(Group, G) end, Rest),
            NewResult = [GroupList | Result],
            groups_of_strings(lists:usort(NextGroups), NewResult, NewSeen)
    end.