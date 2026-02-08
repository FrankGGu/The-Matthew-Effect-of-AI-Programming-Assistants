-module(solution).
-export([solution_init_/1, solution_pick/1]).

-define(MAX_CALLS, 10000).

%% Initialize the Solution with the nums list.
-spec solution_init_([integer()]) -> any().
solution_init_(Nums) ->
    %% Store the indices of each number in a dictionary.
    lists:foldl(fun(N, Acc) ->
                    case maps:find(N, Acc) of
                        {ok, Indices} -> maps:put(N, [length(Indices)|Indices], Acc);
                        error -> maps:put(N, [0], Acc)
                    end
                end, #{}, Nums).

%% Pick a random index where the value matches the target.
-spec solution_pick(integer()) -> integer().
solution_pick(Target) ->
    %% Fetch the list of indices for the given target.
    Indices = maps:get(Target, ?STATE),
    %% Randomly pick an index.
    lists:nth(random:uniform(length(Indices)), Indices).

%% Call solution_init_ once before testing and provide a target.
%% Test case should call solution_pick with the target integer.

