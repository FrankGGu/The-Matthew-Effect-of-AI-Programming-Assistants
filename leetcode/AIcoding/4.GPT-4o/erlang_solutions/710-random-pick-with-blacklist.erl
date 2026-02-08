-module(random_pick_with_blacklist).
-export([new/2, pick/1]).

-record(state, {n, blacklist_map, valid_count}).

new(N, B) ->
    Blacklist = lists:foldl(fun(X, Acc) -> maps:put(X, true, Acc) end, #{}, B),
    ValidCount = N - length(B),
    ValidMap = lists:foldl(fun({X, Y}, Acc) -> maps:put(X, Y, Acc) end, Blacklist, lists:zip(lists:seq(N - length(B), N - 1), lists:seq(0, length(B) - 1))),
    #state{n = N, blacklist_map = ValidMap, valid_count = ValidCount}.

pick(State) ->
    RandomIndex = random:uniform(State#state.valid_count),
    pick_helper(State, RandomIndex, 0).

pick_helper(State, Index, Count) ->
    case maps:find(Count, State#state.blacklist_map) of
        none -> 
            if
                Count == Index -> Count;
                true -> pick_helper(State, Index, Count + 1)
            end;
        _ -> pick_helper(State, Index, Count + 1)
    end.