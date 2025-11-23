-module(solution).
-export([checkRecord/1]).

checkRecord(N) ->
    Mod = 1_000_000_007,
    % State representation: {P0, L1_0, L2_0, P1, L1_1, L2_1}
    % P0: Number of records with 0 'A' and ending with 'P' (or start of string)
    % L1_0: Number of records with 0 'A' and ending with 'L' (one 'L')
    % L2_0: Number of records with 0 'A' and ending with 'LL' (two 'L's)
    % P1: Number of records with 1 'A' and ending with 'P' or 'A'
    % L1_1: Number of records with 1 'A' and ending with 'L' (one 'L')
    % L2_1: Number of records with 1 'A' and ending with 'LL' (two 'L's)

    % Initial state for i=0 (empty string): one way to have 0 'A's and 0 'L's
    InitialState = {1, 0, 0, 0, 0, 0},

    FinalState = lists:foldl(
        fun(_, CurrentState) ->
            {Prev_P0, Prev_L1_0, Prev_L2_0, Prev_P1, Prev_L1_1, Prev_L2_1} = CurrentState,

            % Calculate next state values for length i
            % Records with 0 'A's:
            % Ending with 'P': can come from any 0 'A' state by adding 'P'
            Next_P0 = (Prev_P0 + Prev_L1_0 + Prev_L2_0) rem Mod,
            % Ending with 'L': can come from 0 'A', 0 'L' state by adding 'L'
            Next_L1_0 = Prev_P0 rem Mod,
            % Ending with 'LL': can come from 0 'A', 1 'L' state by adding 'L'
            Next_L2_0 = Prev_L1_0 rem Mod,

            % Records with 1 'A':
            % Ending with 'P' or 'A':
            %   1. From previous 1 'A' states by adding 'P'
            From_P_to_P1 = (Prev_P1 + Prev_L1_1 + Prev_L2_1) rem Mod,
            %   2. From previous 0 'A' states by adding 'A'
            From_A_to_P1 = (Prev_P0 + Prev_L1_0 + Prev_L2_0) rem Mod,
            Next_P1 = (From_P_to_P1 + From_A_to_P1) rem Mod,

            % Ending with 'L': can come from 1 'A', 0 'L' state by adding 'L'
            Next_L1_1 = Prev_P1 rem Mod,
            % Ending with 'LL': can come from 1 'A', 1 'L' state by adding 'L'
            Next_L2_1 = Prev_L1_1 rem Mod,

            {Next_P0, Next_L1_0, Next_L2_0, Next_P1, Next_L1_1, Next_L2_1}
        end,
        InitialState,
        lists:seq(1, N) % Iterate N times to build records up to length N
    ),

    % Sum all valid states for length N
    {Final_P0, Final_L1_0, Final_L2_0, Final_P1, Final_L1_1, Final_L2_1} = FinalState,
    (Final_P0 + Final_L1_0 + Final_L2_0 + Final_P1 + Final_L1_1 + Final_L2_1) rem Mod.