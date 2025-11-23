-module(random_pick_with_weight).
-export([new/1, pick_index/1]).

-record(state, {weights, prefix_sums}).

new(W) ->
    PrefixSums = lists:foldl(fun(X, Acc) -> [ (case Acc of [] -> X; [Last | _] -> X + Last end) | Acc] end, [], W),
    #state{weights = W, prefix_sums = lists:reverse(PrefixSums)}.

pick_index(#state{weights = W, prefix_sums = PrefixSums}) ->
    TotalSum = lists:last(PrefixSums),
    RandomValue = rand:uniform() * TotalSum,
    binary_search(PrefixSums, RandomValue, 0).

binary_search([H | T], Target, Index) ->
    if
        Target =< H ->
            Index;
        true ->
            binary_search(T, Target, Index + 1)
    end.