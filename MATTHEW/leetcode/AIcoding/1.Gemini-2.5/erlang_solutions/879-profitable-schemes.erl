-module(solution).
-export([profitableSchemes/4]).

profitableSchemes(N, MinProfit, Group, Profit) ->
    MOD = 1000000007,

    % dp[g][p] represents the number of schemes that use exactly 'g' members
    % and achieve at least 'p' profit.
    % The profit 'p' is capped at MinProfit, meaning dp[g][MinProfit]
    % stores the count for schemes with 'g' members and profit >= MinProfit.
    %
    % Initialize dp as a map of maps. dp[0][0] = 1 (one way to achieve 0 profit with 0 members).
    % Outer map: member count 'g' -> Inner map
    % Inner map: profit 'p' -> count
    DP0 = #{0 => #{0 => 1}},

    % Iterate through each scheme, updating the DP table
    FinalDP = lists:foldl(
        fun({SchemeGroup, SchemeProfit}, CurrentDP) ->
            % NewDP will hold the state after considering the current scheme.
            % It's initialized with CurrentDP (state before considering this scheme).
            NewDP = CurrentDP, 

            % Iterate 'g' (members) from N down to SchemeGroup
            % This ensures that when we access dp[G - SchemeGroup][P],
            % we are using a value from the *previous* iteration (before this scheme's contribution)
            % or from a smaller 'G' value that has already been updated for this scheme.
            % The key is that dp[G - SchemeGroup][P] is from CurrentDP (the state before this scheme)
            % and dp[G][NewProfitIdx] is from NewDP (the state being built for this scheme).
            lists:foldl(
                fun(G, AccDP_G) -> % AccDP_G is the DP table being built for the current scheme
                    % Iterate 'p' (profit) from MinProfit down to 0
                    lists:foldl(
                        fun(P, AccDP_P) -> % AccDP_P is the DP table being built for the current scheme
                            % Get the count for dp[G - SchemeGroup][P] from CurrentDP
                            % (the state *before* processing the current scheme)
                            PrevCount = maps:get(P, maps:get(G - SchemeGroup, CurrentDP, #{}), 0),

                            if PrevCount > 0 ->
                                % Calculate the new profit index, capped at MinProfit
                                NewProfitIdx = min(MinProfit, P + SchemeProfit),

                                % Get the current count for dp[G][NewProfitIdx] from AccDP_P
                                % (the table being updated for the current scheme)
                                CurrentCount = maps:get(NewProfitIdx, maps:get(G, AccDP_P, #{}), 0),

                                % Update dp[G][NewProfitIdx]
                                UpdatedCount = (CurrentCount + PrevCount) rem MOD,

                                % Update the inner map for G and then the outer map
                                RowG = maps:get(G, AccDP_P, #{}),
                                NewRowG = maps:put(NewProfitIdx, UpdatedCount, RowG),
                                maps:put(G, NewRowG, AccDP_P);
                            true ->
                                AccDP_P % No change if PrevCount is 0
                            end
                        end,
                        AccDP_G, % Pass the DP table being built for the current scheme
                        lists:seq(MinProfit, 0, -1)
                    )
                end,
                NewDP, % Start with NewDP (which is CurrentDP initially for this scheme)
                lists:seq(N, SchemeGroup, -1)
            )
        end,
        DP0,
        lists:zip(Group, Profit)
    ),

    % The final answer is the sum of dp[g][MinProfit] for all 'g' from 0 to N.
    % This represents all schemes that use 'g' members and achieve *at least* MinProfit.
    TotalSchemes = lists:foldl(
        fun(G, Sum) ->
            % Get the count for dp[G][MinProfit]
            Count = maps:get(MinProfit, maps:get(G, FinalDP, #{}), 0),
            (Sum + Count) rem MOD
        end,
        0,
        lists:seq(0, N)
    ),

    TotalSchemes.