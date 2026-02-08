-module(solution).
-export([max_score_sightings/1]).

max_score_sightings(Nums) ->
    N = length(Nums),

    % Step 1: Calculate initial score (for k=0) and populate the change array
    {InitialScore, ChangeArray} = calculate_initial_score_and_changes(Nums, N),

    % Step 2: Iterate through k from 1 to N-1 to find the best rotation
    find_best_rotation(N, ChangeArray, InitialScore).

calculate_initial_score_and_changes(Nums, N) ->
    InitialScore = 0,
    ChangeArray = array:new(N, {default, 0}),

    % Use a 0-indexed loop for J
    {Score0, FinalChangeArray} = lists:foldl(
        fun(J, {AccScore, AccChangeArray}) ->
            Val = lists:nth(J + 1, Nums), % Erlang lists are 1-indexed for nth

            CurrentAccScore = if Val =< J -> AccScore + 1; true -> AccScore end,

            % k_lose: when Nums[J] at index J moves to Val-1
            % (J - k + N) mod N = Val - 1
            % k = (J - (Val - 1) + N) mod N = (J - Val + 1 + N) mod N
            K_lose_raw = J - Val + 1,
            K_lose = (K_lose_raw rem N + N) rem N, % Ensure positive modulo

            % k_gain: when Nums[J] at index J moves to Val
            % (J - k + N) mod N = Val
            % k = (J - Val + N) mod N
            K_gain_raw = J - Val,
            K_gain = (K_gain_raw rem N + N) rem N, % Ensure positive modulo

            UpdatedChangeArray1 = array:set(K_lose, array:get(K_lose, AccChangeArray) - 1, AccChangeArray),
            UpdatedChangeArray2 = array:set(K_gain, array:get(K_gain, UpdatedChangeArray1) + 1, UpdatedChangeArray1),

            {CurrentAccScore, UpdatedChangeArray2}
        end,
        {InitialScore, ChangeArray},
        lists:seq(0, N - 1) % J from 0 to N-1
    ),
    {Score0, FinalChangeArray}.

find_best_rotation(N, ChangeArray, Score0) ->
    % Initial state for foldl: {MaxScore, BestK, CurrentScore}
    InitialState = {Score0, 0, Score0},

    {_FinalMaxScore, FinalBestK, _FinalCurrentScore} = lists:foldl(
        fun(K, {AccMaxScore, AccBestK, AccCurrentScore}) ->
            Change = array:get(K, ChangeArray),
            NewCurrentScore = AccCurrentScore + Change,

            % If new score is strictly greater, update.
            % If equal, problem asks for smallest K, so don't update.
            if NewCurrentScore > AccMaxScore ->
                {NewCurrentScore, K, NewCurrentScore};
            true ->
                {AccMaxScore, AccBestK, NewCurrentScore}
            end
        end,
        InitialState,
        lists:seq(1, N - 1) % K from 1 to N-1
    ),
    FinalBestK.