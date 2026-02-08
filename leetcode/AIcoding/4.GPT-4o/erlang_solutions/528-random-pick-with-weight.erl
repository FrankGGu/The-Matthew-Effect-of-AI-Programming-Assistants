-module(solution).
-export([solution_init_/1, solution_pick_index/0]).

-define(MAX_CALLS, 10000).

%% Initialize the Solution with the weight array.
-spec solution_init_([integer()]) -> any().
solution_init_(W) ->
    %% Calculate the prefix sum of the weights
    PrefixSum = lists:foldl(fun(X, Acc) -> [X + hd(Acc) | Acc] end, [0], lists:reverse(W)),
    %% Store the prefix sum list
    {ok, PrefixSum}.

%% Pick an index based on the weights using random probability.
-spec solution_pick_index() -> integer().
solution_pick_index() ->
    %% Fetch the prefix sum list.
    PrefixSum = maps:get(?STATE),
    TotalSum = hd(PrefixSum),
    Rand = random:uniform(TotalSum),
    %% Binary search to find the index corresponding to the random value.
    Index = binary_search(Rand, PrefixSum),
    Index.

%% Binary search to find the appropriate index based on the random value.
-spec binary_search(integer(), [integer()]) -> integer().
binary_search(Rand, [H | T]) when Rand =< H -> 0;
b
