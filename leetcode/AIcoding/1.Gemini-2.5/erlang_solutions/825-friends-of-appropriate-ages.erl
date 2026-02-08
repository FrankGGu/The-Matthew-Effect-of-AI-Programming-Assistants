-module(solution).
-export([numFriendRequests/1]).

numFriendRequests(Ages) ->
    % Max age is 120. Use an array of size 121 for ages 0-120.
    % Counts[i] stores the number of people with age i.
    Counts = lists:foldl(fun(Age, Acc) ->
                                 array:set(Age, array:get(Age, Acc) + 1, Acc)
                         end,
                         array:new({size, 121}, {default, 0}),
                         Ages),

    % PrefixSums[i] stores the sum of Counts[j] for j from 0 to i.
    PrefixSums = make_prefix_sums(1, Counts, array:new({size, 121}, {default, 0})),

    calculate_requests(1, Counts, PrefixSums, 0).

make_prefix_sums(Age, Counts, AccPrefixSums) when Age =< 120 ->
    PrevSum = array:get(Age - 1, AccPrefixSums),
    CurrentCount = array:get(Age, Counts),
    NewAccPrefixSums = array:set(Age, PrevSum + CurrentCount, AccPrefixSums),
    make_prefix_sums(Age + 1, Counts, NewAccPrefixSums);
make_prefix_sums(_Age, _Counts, AccPrefixSums) ->
    AccPrefixSums.

calculate_requests(AgeX, Counts, PrefixSums, TotalRequests) when AgeX =< 120 ->
    CountX = array:get(AgeX, Counts),
    NewTotalRequests =
        if CountX == 0 ->
                TotalRequests;
           true ->
                % Conditions for Y to receive request from X:
                % ageY > 0.5 * ageX + 7
                % ageY <= ageX
                MinAgeY = trunc(0.5 * AgeX + 7) + 1, % floor(0.5 * ageX + 7) + 1
                MaxAgeY = AgeX,

                % Ensure MinAgeY is at least 1 and MaxAgeY is at most 120
                AdjustedMinAgeY = max(1, MinAgeY),
                AdjustedMaxAgeY = min(120, MaxAgeY),

                IfRangeValid =
                    if AdjustedMinAgeY > AdjustedMaxAgeY ->
                            0; % No valid ageY range
                       true ->
                            % Number of people whose ageY satisfies the conditions
                            NumPotentialFriends = array:get(AdjustedMaxAgeY, PrefixSums) - array:get(AdjustedMinAgeY - 1, PrefixSums),

                            % Add requests from people of age AgeX to others.
                            % If AgeX is in [AdjustedMinAgeY, AdjustedMaxAgeY], then CountX is included in NumPotentialFriends.
                            % We need to subtract CountX because a person doesn't send a request to themselves (i != j).
                            SelfRequestCorrection =
                                if AgeX >= AdjustedMinAgeY andalso AgeX <= AdjustedMaxAgeY ->
                                        CountX;
                                   true ->
                                        0
                                end,
                            (CountX * NumPotentialFriends) - SelfRequestCorrection
                    end,
                TotalRequests + IfRangeValid
        end,
    calculate_requests(AgeX + 1, Counts, PrefixSums, NewTotalRequests);
calculate_requests(_AgeX, _Counts, _PrefixSums, TotalRequests) ->
    TotalRequests.