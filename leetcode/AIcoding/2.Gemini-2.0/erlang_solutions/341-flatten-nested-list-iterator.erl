-module(nested_list_iterator).
-export([nested_list_iterator/1, has_next/1, next/1]).

-record(state, {list, current_value}).

nested_list_iterator(NestedList) ->
    #state{list = flatten(NestedList), current_value = undefined}.

has_next(#state{list = []}) ->
    false;
has_next(#state{list = _}) ->
    true.

next(#state{list = [H | T]} = State) ->
    {H, State#state{list = T, current_value = H}}.

flatten(List) ->
    flatten_helper(List, []).

flatten_helper([], Acc) ->
    lists:reverse(Acc);
flatten_helper([H | T], Acc) when is_integer(H) ->
    flatten_helper(T, [H | Acc]);
flatten_helper([H | T], Acc) when is_list(H) ->
    flatten_helper(T, flatten_helper(H, Acc));
flatten_helper(Other, Acc) ->
    flatten_helper([], Acc).