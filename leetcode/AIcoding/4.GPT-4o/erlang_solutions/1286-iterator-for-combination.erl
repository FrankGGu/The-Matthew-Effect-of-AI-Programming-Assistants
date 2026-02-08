-module(combination_iterator).
-export([new/2, next/1, hasNext/1]).

-record(state, {n, k, current, combinations}).

new(N, K) ->
    Combs = combinations(N, K, lists:seq(1, N)),
    #state{n=N, k=K, current=0, combinations=Combs}.

next(Iterator) ->
    case hasNext(Iterator) of
        true ->
            NewCurrent = Iterator#state.current + 1,
            {lists:nth(NewCurrent, Iterator#state.combinations), Iterator#state#state{current=NewCurrent}};
        false ->
            {[], Iterator}
    end.

hasNext(Iterator) ->
    Iterator#state.current < length(Iterator#state.combinations).

combinations(0, _, _) -> [[]];
combinations(_, 0, _) -> [[]];
combinations(N, K, List) ->
    [H | T] = List,
    [ [H | Rest] || Rest <- combinations(N - 1, K - 1, T) ] ++ combinations(N - 1, K, T).