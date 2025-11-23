#include <stdlib.h>
#include <stdbool.h>

bool* canEat(int* candiesCount, int candiesCountSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    long long* prefixSum = (long long*)malloc((candiesSize + 1) * sizeof(long long));
    prefixSum[0] = 0;
    for (int i = 0; i < candiesCountSize; ++i) {
        prefixSum[i + 1] = prefixSum[i] + candiesCount[i];
    }

    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; ++i) {
        int candyType_i = queries[i][0];
        int day_i = queries[i][1];
        int dailyCap_i = queries[i][2];

        // The range of 0-indexed candy indices for candyType_i
        // The first candy of type candyType_i is at index prefixSum[candyType_i]
        // The last candy of type candyType_i is at index prefixSum[candyType_i + 1] - 1
        long long min_idx_candy_type_i = prefixSum[candyType_i];
        long long max_idx_candy_type_i = prefixSum[candyType_i + 1] - 1;

        // The range of 0-indexed candy indices we could eat on day_i (0-indexed day)
        // Earliest candy index we could eat on day_i:
        // If we eat 1 candy per day, by the end of day (day_i - 1), we've eaten `day_i` candies (indices 0 to day_i - 1).
        // So, on day_i, we start eating candy at index `day_i`.
        long long earliest_candy_idx_on_day_i = (long long)day_i * 1;

        // Latest candy index we could eat on day_i:
        // If we eat dailyCap_i candies per day, by the end of day day_i, we've eaten (day_i + 1) * dailyCap_i candies.
        // These are indices 0 to (day_i + 1) * dailyCap_i - 1.
        // So, the last candy eaten on day_i is at index (day_i + 1) * dailyCap_i - 1.
        long long latest_candy_idx_on_day_i = (long long)(day_i + 1) * dailyCap_i - 1;

        // Check for overlap between the two ranges:
        // Range 1: [min_idx_candy_type_i, max_idx_candy_type_i] (candies of type candyType_i)
        // Range 2: [earliest_candy_idx_on_day_i, latest_candy_idx_on_day_i] (candies we can eat on day_i)
        // Overlap exists if start1 <= end2 AND start2 <= end1

        bool overlap = (earliest_candy_idx_on_day_i <= max_idx_candy_type_i) && 
                       (min_idx_candy_type_i <= latest_candy_idx_on_day_i);

        result[i] = overlap;
    }

    free(prefixSum);
    return result;
}