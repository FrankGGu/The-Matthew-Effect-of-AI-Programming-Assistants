#include <stdlib.h> // For qsort, calloc
#include <string.h> // Not strictly needed, but often included

int compareOffers(const void* a, const void* b) {
    const int* offerA = *(const int**)a;
    const int* offerB = *(const int**)b;

    if (offerA[1] != offerB[1]) {
        return offerA[1] - offerB[1];
    }
    return offerA[0] - offerB[0];
}

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long maximizeTheProfit(int** offers, int offersSize, int* offersColSize) {
    if (offersSize == 0) {
        return 0;
    }

    // Sort the offers based on their end times.
    // This is crucial for the dynamic programming approach with binary search.
    qsort(offers, offersSize, sizeof(int*), compareOffers);

    // dp[i] will store the maximum profit that can be achieved considering
    // the first 'i' offers (i.e., offers[0] through offers[i-1]) after sorting.
    // The dp array is 1-indexed with respect to the sorted offers array.
    // dp[0] corresponds to no offers considered, so profit is 0.
    long long* dp = (long long*)calloc(offersSize + 1, sizeof(long long));
    // calloc initializes all elements to zero, so dp[0] is already 0.

    for (int i = 1; i <= offersSize; ++i) {
        int current_start = offers[i-1][0];
        int current_profit = offers[i-1][2];

        // Option 1: Do not take the current offer (offers[i-1]).
        // The maximum profit remains the same as considering offers[0...i-2].
        long long profit_not_take = dp[i-1];

        // Option 2: Take the current offer (offers[i-1]).
        // If we take this offer, we cannot take any offers that overlap with it.
        // We need to find the maximum profit from previous non-overlapping offers.
        long long profit_take = current_profit;

        // Binary search to find the latest offer `j` (0-indexed in the sorted `offers` array)
        // such that `offers[j][1] < current_start`. This means offer `j` ends before
        // the current offer `i-1` starts, so they don't overlap.
        // The search space for `j` is `offers[0...i-2]`.
        int low = 0;
        int high = i - 2; // Index of the last possible previous offer to consider
        int prev_max_idx = -1; // Stores the 0-indexed position of the best non-overlapping previous offer found

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (offers[mid][1] < current_start) {
                // This offer `mid` is non-overlapping. It's a candidate.
                // Try to find an even later non-overlapping offer.
                prev_max_idx = mid;
                low = mid + 1;
            } else {
                // This offer `mid` overlaps or ends too late.
                // Look for earlier offers.
                high = mid - 1;
            }
        }

        if (prev_max_idx != -1) {
            // If a non-overlapping previous offer was found, add the maximum profit
            // achievable up to that offer (plus its own profit if taken).
            // dp[prev_max_idx + 1] holds the max profit considering offers[0...prev_max_idx].
            profit_take += dp[prev_max_idx + 1];
        }

        // The maximum profit for `dp[i]` is the maximum of taking or not taking the current offer.
        dp[i] = max(profit_not_take, profit_take);
    }

    // The final result is the maximum profit considering all offers.
    long long result = dp[offersSize];

    // Free the dynamically allocated memory for the dp array.
    free(dp);

    return result;
}