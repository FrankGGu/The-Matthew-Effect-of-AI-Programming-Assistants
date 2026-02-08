-module(solution).
-export([min_days/3]).

min_days(BloomDay, M, K) ->
    N = length(BloomDay),
    RequiredFlowers = M * K,

    % If the total number of flowers required for M bouquets (M*K)
    % exceeds the total number of available flowers (N), it's impossible.
    % Assuming M and K are positive based on typical problem constraints.
    if RequiredFlowers > N ->
        -1;
    true ->
        % The minimum possible day is 1 (or the earliest bloom day),
        % and the maximum possible day is the latest bloom day.
        MinVal = lists:min(BloomDay),
        MaxVal = lists:max(BloomDay),

        % Perform binary search on the number of days.
        binary_search(MinVal, MaxVal, BloomDay, M, K)
    end.

binary_search(Low, High, BloomDay, M, K) ->
    if Low > High ->
        % When Low exceeds High, Low holds the smallest day that satisfies the condition.
        Low;
    true ->
        Mid = Low + (High - Low) div 2, % Calculate mid-point to avoid overflow for large Low/High

        % Check if it's possible to make M bouquets by 'Mid' day.
        if check(Mid, BloomDay, K) >= M ->
            % If possible, 'Mid' is a potential answer. Try to find an even smaller day.
            binary_search(Low, Mid - 1, BloomDay, M, K);
        true ->
            % If not possible, 'Mid' is too small. Need more days.
            binary_search(Mid + 1, High, BloomDay, M, K)
        end
    end.

check(Day, BloomDay, K) ->
    count_bouquets(BloomDay, K, Day, 0, 0).

count_bouquets([], _K, _Day, _CurrentConsecutive, BouquetsMade) ->
    BouquetsMade;
count_bouquets([H|T], K, Day, CurrentConsecutive, BouquetsMade) ->
    if H =< Day ->
        % If the current flower has bloomed by 'Day'.
        NewConsecutive = CurrentConsecutive + 1,
        if NewConsecutive >= K ->
            % If we have enough consecutive bloomed flowers, form a bouquet.
            % Reset consecutive count and increment bouquets made.
            count_bouquets(T, K, Day, 0, BouquetsMade + 1);
        true ->
            % Not enough consecutive flowers yet, continue counting.
            count_bouquets(T, K, Day, NewConsecutive, BouquetsMade)
        end;
    true ->
        % If the current flower has not bloomed by 'Day', break the consecutive sequence.
        % Reset consecutive count.
        count_bouquets(T, K, Day, 0, BouquetsMade)
    end.