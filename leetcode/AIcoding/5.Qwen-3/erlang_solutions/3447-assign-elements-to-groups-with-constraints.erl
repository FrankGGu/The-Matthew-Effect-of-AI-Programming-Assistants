-module(assign_elements_to_groups).
-export([assign/1]).

assign(Elements) ->
    assign(Elements, dict:new(), dict:new(), 0).

assign([], _, _, _) ->
    ok;

assign([E | Rest], GroupMap, ParentMap, GroupId) ->
    case dict:is_key(E, GroupMap) of
        true ->
            assign(Rest, GroupMap, ParentMap, GroupId);
        false ->
            NewGroupMap = dict:store(E, GroupId, GroupMap),
            NewParentMap = dict:store(GroupId, GroupId, ParentMap),
            assign(Rest, NewGroupMap, NewParentMap, GroupId + 1)
    end.