-module(KthLargest).
-export([new/2, add/2]).

-record(state, {k, nums = []}).

new(K, nums) ->
    {ok, #state{k = K, nums = lists:sort(nums)}}.

add(State, val) ->
    NewNums = lists:insert(val, State#state.nums),
    NewK = State#state.k,
    SortedNums = lists:sort(NewNums),
    {ok, lists:nth(min(NewK, length(SortedNums)), SortedNums)}.