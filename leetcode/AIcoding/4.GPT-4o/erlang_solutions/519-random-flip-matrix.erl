-module(solution).
-export([solution_init_/2, solution_flip/0, solution_reset/0]).

-define(MAX_CALLS, 1000).

%% Initialize the matrix with all elements set to 0 and store the available positions.
-spec solution_init_(integer(), integer()) -> any().
solution_init_(M, N) ->
    %% Create a list of all positions (i, j) in the matrix
    Positions = lists:flatmap(fun(I) ->
                                  lists:map(fun(J) -> {I, J} end, lists:seq(0, N-1))
                              end, lists:seq(0, M-1)),
    %% Store the positions as a list of available positions
    put(available_positions, Positions),
    %% Store the size of the matrix
    put(matrix_size, {M, N}).

%% Flip a random (i, j) index from the available positions and set it to 1.
-spec solution_flip() -> [integer()].
solution_flip() ->
    %% Get the list of available positions
    Positions = get(available_positions),
    %% Pick a random index from the available positions
    RandomIndex = random:uniform(length(Positions)),
    {I, J} = lists:nth(RandomIndex, Positions),
    %% Remove the chosen position from the available positions
    NewPositions = lists:delete({I, J}, Positions),
    %% Update the available positions
    put(available_positions, NewPositions),
    %% Return the flipped position
    [I, J].

%% Reset the matrix by resetting all values to 0 and restoring the available positions.
-spec solution_reset() -> any().
solution_reset() ->
    %% Get the size of the matrix
    {M, N} = get(matrix_size),
    %% Rebuild the list of all positions
    Positions = lists:flatmap(fun(I) ->
                                  lists:map(fun(J) -> {I, J} end, lists:seq(0, N-1))
                              end, lists:seq(0, M-1)),
    %% Restore the available positions
    put(available_positions, Positions).
