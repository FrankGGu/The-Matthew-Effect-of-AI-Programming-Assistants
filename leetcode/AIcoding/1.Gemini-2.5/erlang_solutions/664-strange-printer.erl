-module(solution).
-export([strange_printer/1]).

strange_printer(S) ->
    N = string:len(S),
    if N == 0 -> 0;
       true ->
            % DP table: Map where keys are {I, J} (0-based indices) and values are minimum turns.
            % Initialize DP for length 1 substrings (dp[i][i] = 1)
            InitialDP = lists:foldl(
                fun(Idx, AccDP) ->
                    AccDP#{ {Idx, Idx} => 1 }
                end,
                #{},
                lists:seq(0, N - 1)
            ),

            % Iterate over substring lengths from 2 to N
            FinalDP = lists:foldl(
                fun(Len, AccDP_PrevLen) ->
                    % For each length, iterate over possible starting indices I
                    lists:foldl(
                        fun(I, AccDP_CurrentLen) ->
                            J = I + Len - 1,
                            Char_I = lists:nth(I + 1, S), % Get character at index I (0-based)

                            % Option 1: Print Char_I in a new turn, then solve for S[I+1...J]
                            % maps:get({I + 1, J}, AccDP_CurrentLen, 0) handles cases where I+1 > J (empty substring)
                            Val1 = 1 + maps:get({I + 1, J}, AccDP_CurrentLen, 0),

                            % Option 2: Find k where S[k] == S[I] and combine prints
                            % Iterate k from I+1 to J
                            MinVal = lists:foldl(
                                fun(K, CurrentMin) ->
                                    Char_K = lists:nth(K + 1, S),
                                    if Char_K == Char_I ->
                                        % If S[K] == S[I], we can potentially print S[I] and S[K] in the same turn.
                                        % The cost would be dp[I][K-1] + dp[K+1][J].
                                        % S[K] is covered by the same turn as S[I].
                                        % maps:get/3 handles empty substrings (e.g., K-1 < I or K+1 > J)
                                        Term1 = maps:get({I, K - 1}, AccDP_CurrentLen, 0),
                                        Term2 = maps:get({K + 1, J}, AccDP_CurrentLen, 0),
                                        min(CurrentMin, Term1 + Term2)
                                    ;
                                       true -> CurrentMin
                                    end
                                end,
                                Val1, % Start with Val1 (from Option 1) as the initial minimum
                                lists:seq(I + 1, J)
                            ),
                            AccDP_CurrentLen#{ {I, J} => MinVal }
                        end,
                        AccDP_PrevLen, % Pass the DP map from previous length iterations
                        lists:seq(0, N - Len) % Iterate I from 0 to N - Len
                    )
                end,
                InitialDP,
                lists:seq(2, N) % Iterate Len from 2 to N
            ),
            maps:get({0, N - 1}, FinalDP) % The result is dp[0][N-1]
    end.