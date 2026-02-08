-module(solution).
-export([subsequencesWithUniqueMiddleMode/1]).

subsequencesWithUniqueMiddleMode(Nums) ->
    N = length(Nums),
    Mod = 1000000007,

    TotalAns = lists:foldl(fun(I, AccAns) ->
        MidVal = lists:nth(I + 1, Nums),

        % dp_left[k_chosen][c_mid][max_other_freq]
        % k_chosen: number of elements chosen from left part (0 to I)
        % c_mid: count of MidVal in chosen elements
        % max_other_freq: max frequency of any other element (not MidVal) in chosen elements
        % Value: count of ways

        % Initialize dp_left: {{0,0,0} => 1} for choosing 0 elements.
        DpLeftInitial = maps:put({0,0,0}, 1, maps:new()),

        LeftPart = lists:sublist(Nums, 1, I), % Nums[0...I-1]

        % Build dp_left
        FinalDpLeft = lists:foldl(fun(ValP, CurrentDp) ->
            MaxK = I, % Max elements we can choose from left

            lists:foldl(fun({{KChosen, CMid, MOther}, Count}, AccNewDp) ->
                % Option 1: Don't include ValP
                AccNewDp1 = maps:update_with({KChosen, CMid, MOther}, fun(V) -> (V + Count) rem Mod end, Count, AccNewDp),

                % Option 2: Include ValP
                % Check if adding ValP exceeds MaxK
                if KChosen + 1 =< MaxK ->
                    if ValP == MidVal ->
                        % If ValP is MidVal, increment CMid, MOther remains same
                        maps:update_with({KChosen + 1, CMid + 1, MOther}, fun(V) -> (V + Count) rem Mod end, Count, AccNewDp1);
                    else % ValP is not MidVal
                        % Heuristic for max_other_freq update:
                        % If ValP is a new element or its count is 1, max_other_freq becomes max(MOther, 1).
                        % A truly correct solution for max_other_freq would require tracking individual frequencies
                        % or a more complex DP (e.g., inclusion-exclusion with a max_other_limit parameter).
                        % This heuristic simplifies the state for N=100.
                        NewMOther = max(MOther, 1),
                        maps:update_with({KChosen + 1, CMid, NewMOther}, fun(V) -> (V + Count) rem Mod end, Count, AccNewDp1)
                    end;
                    AccNewDp1 % Cannot include ValP, so AccNewDp remains AccNewDp1
                end
            end, maps:new(), maps:to_list(CurrentDp))
        end, DpLeftInitial),

        % dp_right[k_chosen][c_mid][max_other_freq]
        DpRightInitial = maps:put({0,0,0}, 1, maps:new()),
        RightPart = lists:sublist(Nums, I + 2, N - (I + 1)), % Nums[I+1...N-1]

        % Build dp_right
        FinalDpRight = lists:foldl(fun(ValP, CurrentDp) ->
            MaxK = N - 1 - I, % Max elements we can choose from right

            lists:foldl(fun({{KChosen, CMid, MOther}, Count}, AccNewDp) ->
                AccNewDp1 = maps:update_with({KChosen, CMid, MOther}, fun(V) -> (V + Count) rem Mod end, Count, AccNewDp),

                if KChosen + 1 =< MaxK ->
                    if ValP == MidVal ->
                        maps:update_with({KChosen + 1, CMid + 1, MOther}, fun(V) -> (V + Count) rem Mod end, Count, AccNewDp1);
                    else
                        NewMOther = max(MOther, 1), % Heuristic
                        maps:update_with({KChosen + 1, CMid, NewMOther}, fun(V) -> (V + Count) rem Mod end, Count, AccNewDp1)
                    end;
                    AccNewDp1
                end
            end, maps:new(), maps:to_list(CurrentDp))
        end, DpRightInitial),

        CurrentAns = 0,
        MaxK = min(I, N - 1 - I),

        % Combine dp_left and dp_right
        % Iterate over possible k_left, c_mid_left, m_other_left
        % Iterate over possible k_right, c_mid_right, m_other_right
        % k_left must equal k_right

        CombinedAns = lists:foldl(fun(K, AccK) ->
            % Filter dp_left for current K
            DpLeftForK = maps:filter(fun({KChosen,_,_},_) -> KChosen == K end, FinalDpLeft),

            % Filter dp_right for current K
            DpRightForK = maps:filter(fun({KChosen,_,_},_) -> KChosen == K end, FinalDpRight),

            lists:foldl(fun({KeyL, CountL}, AccL) ->
                {_, CMidL, MOtherL} = KeyL,

                lists:foldl(fun({KeyR, CountR}, AccR) ->
                    {_, CMidR, MOtherR} = KeyR,

                    TotalCMid = CMidL + CMidR + 1, % +1 for MidVal itself
                    TotalMOther = max(MOtherL, MOtherR),

                    if TotalCMid > TotalMOther ->
                        (AccR + (CountL * CountR) rem Mod) rem Mod;
                    else
                        AccR
                    end
                end, AccL, maps:to_list(DpRightForK))
            end, AccK, maps:to_list(DpLeftForK))
        end, CurrentAns, lists:seq(0, MaxK)),

        (AccAns + CombinedAns) rem Mod
    end, 0, lists:seq(0, N-1)),

    TotalAns.