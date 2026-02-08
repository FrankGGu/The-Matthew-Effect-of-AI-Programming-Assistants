-module(rank_tracker).
-export([new/0, add/3, get/1]).

-record(tracker_state, {
    tree :: gb_trees:gb_tree(),
    k_ptr :: integer()
}).

new() ->
    #tracker_state{tree = gb_trees:empty(), k_ptr = 0}.

add(State, LocationName, LocationScore) ->
    Key = {LocationScore, LocationName},
    NewTree = gb_trees:insert(Key, true, State#tracker_state.tree),
    State#tracker_state{tree = NewTree}.

get(State) ->
    NewKPtr = State#tracker_state.k_ptr + 1,
    {Key, _Value} = gb_trees:get_nth(NewKPtr, State#tracker_state.tree),
    {_Score, Name} = Key,
    {Name, State#tracker_state{k_ptr = NewKPtr}}.