-module(finding_pairs).
-export([start/0, add/2, count/1]).

-record(state, {nums1, nums2}).

start() ->
    State = #state{nums1 = [], nums2 = []},
    ets:new(nums1, [set, public, named_table]),
    ets:new(nums2, [set, public, named_table]),
    {ok, State}.

add(Index, Value) ->
    State = get_state(),
    case Index of
        0 ->
            Nums1 = State#state.nums1,
            ets:insert(nums1, {length(Nums1), Value}),
            put_state(State#state{nums1 = Nums1 ++ [Value]});
        1 ->
            Nums2 = State#state.nums2,
            ets:insert(nums2, {length(Nums2), Value}),
            put_state(State#state{nums2 = Nums2 ++ [Value]})
    end,
    ok.

count(Target) ->
    State = get_state(),
    Nums1 = State#state.nums1,
    Nums2 = State#state.nums2,
    count_pairs(Nums1, Nums2, Target, 0).

count_pairs([], _, _, Acc) ->
    Acc;
count_pairs([H|T], Nums2, Target, Acc) ->
    Count = lists:foldl(fun(Num, C) ->
                                if Num == Target - H then
                                    C + 1
                                else
                                    C
                                end
                            end, 0, Nums2),
    count_pairs(T, Nums2, Target, Acc + Count).

get_state() ->
    process_info(self(), dictionary).

put_state(State) ->
    put(state, State).