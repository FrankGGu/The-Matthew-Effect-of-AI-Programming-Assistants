-module(mk_avg).
-export([init/3, add_element/2, calculate_mk_avg/1]).

-record(state, {
    m :: integer(),
    k :: integer(),
    queue = queue:new() :: queue:queue(integer()),
    sorted = [] :: list(integer()),
    sum = 0 :: integer()
}).

-spec init(M :: integer(), K :: integer(), Nums :: [integer()]) -> any().
init(M, K, Nums) ->
    State = #state{m = M, k = K},
    lists:foldl(fun add_element/2, State, Nums).

-spec add_element(Num :: integer(), State :: any()) -> any().
add_element(Num, #state{m = M, k = K, queue = Q, sorted = Sorted, sum = Sum} = State) ->
    {Q1, Removed} = if
        queue:len(Q) < M -> {queue:in(Num, Q), none};
        true ->
            {{value, R}, Q2} = queue:out(Q),
            {queue:in(Num, Q2), R}
    end,
    Sorted1 = case Removed of
        none -> lists:merge(Sorted, [Num]);
        R ->
            SortedR = lists:delete(R, Sorted),
            lists:merge(SortedR, [Num])
    end,
    Sum1 = case queue:len(Q1) of
        L when L < M -> Sum + Num;
        _ ->
            case Removed of
                none -> Sum + Num;
                R -> Sum - R + Num
            end
    end,
    State#state{queue = Q1, sorted = Sorted1, sum = Sum1}.

-spec calculate_mk_avg(State :: any()) -> integer().
calculate_mk_avg(#state{m = M, k = K, queue = Q, sorted = Sorted, sum = Sum}) ->
    case queue:len(Q) < M of
        true -> -1;
        false ->
            SubList = lists:sublist(Sorted, K + 1, M - 2 * K),
            lists:sum(SubList) div length(SubList)
    end.