-module(ordinal_rank_tracker).
-export([new/0, track/2, get_rank/1]).

-record(state, {rank_map = #{}, total_count = 0}).

new() ->
    #state{}.

track(State, Number) ->
    RankMap = maps:update_with(Number, fun(X) -> X + 1 end, fun() -> 1 end, State#state.rank_map),
    TotalCount = State#state.total_count + 1,
    State1 = State#state{rank_map = RankMap, total_count = TotalCount},
    {State1, TotalCount}.

get_rank(State) ->
    RankMap = State#state.rank_map,
    SortedRanks = maps:to_list(RankMap),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, SortedRanks),
    lists:map(fun({Key, _}) -> Key end, Sorted).