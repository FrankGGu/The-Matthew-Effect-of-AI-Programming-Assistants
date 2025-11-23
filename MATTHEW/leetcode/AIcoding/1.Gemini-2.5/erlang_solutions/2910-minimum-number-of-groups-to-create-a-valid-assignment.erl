-module(solution).
-export([minimum_groups_to_create_valid_assignment/1]).

minimum_groups_to_create_valid_assignment(Nums) ->
    % 1. Count frequencies of each item type
    FreqMap = lists:foldl(fun(Num, Acc) -> maps:update_with(Num, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Nums),
    Freqs = maps:values(FreqMap),

    % 2. Find the minimum frequency among all item types
    MinFreq = lists:min(Freqs),

    % 3. Iterate through possible minimum group sizes 'S'
    %    'S' can range from 1 up to MinFreq.
    %    For each 'S', calculate the total number of groups needed.
    %    Keep track of the overall minimum total groups.
    solve(1, MinFreq, Freqs, infinity).

solve(S, MaxS, Freqs, MinTotalGroups) when S > MaxS ->
    % Base case: All possible 'S' values have been checked
    MinTotalGroups;
solve(S, MaxS, Freqs, CurrentMinTotalGroups) ->
    % For the current 'S', calculate the total number of groups required
    case calculate_total_groups_for_s(S, Freqs) of
        invalid ->
            % If 'S' is not a valid minimum group size for all frequencies,
            % skip this 'S' and try the next one.
            solve(S + 1, MaxS, Freqs, CurrentMinTotalGroups);
        TotalGroups ->
            % If 'S' is valid, update the overall minimum total groups found so far.
            solve(S + 1, MaxS, Freqs, min(CurrentMinTotalGroups, TotalGroups))
    end.

calculate_total_groups_for_s(S, Freqs) ->
    lists:foldl(fun(F, Acc) ->
        case Acc of
            invalid -> Acc; % If already determined as invalid, propagate
            CurrentTotal ->
                % Calculate K_min = ceil(F / (S + 1))
                % This is the minimum number of groups required for frequency F,
                % if groups can be of size S or S+1.
                K_min = (F + S) div (S + 1),

                % Calculate K_max = floor(F / S)
                % This is the maximum number of groups possible for frequency F,
                % if groups can be of size S or S+1 (specifically, all groups of size S).
                K_max = F div S,

                % If K_min > K_max, it means it's impossible to form groups of size S or S+1
                % for this frequency F with the given S.
                % Thus, this S is invalid for the entire assignment.
                if
                    K_min > K_max -> invalid;
                    true -> CurrentTotal + K_min
                end
        end
    end, 0, Freqs).