#include <stdlib.h> // For malloc, free, qsort

typedef struct {
    int start;
    int end;
    int score;
} Interval;

int compareIntervals(const void *a, const void *b) {
    return ((Interval*)a)->end - ((Interval*)b)->end;
}

int findPrecedingInterval(Interval *intervals, int n, int currentIntervalIndex) {
    int low = 0, high = currentIntervalIndex - 1;
    int ans = -1; // Stores the index of the latest non-overlapping interval found

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (intervals[mid].end <= intervals[currentIntervalIndex].start) {
            ans = mid; // This interval is non-overlapping, try to find a later one
            low = mid + 1;
        } else {
            high = mid - 1; // This interval overlaps, or is too late, look earlier
        }
    }
    return ans;
}

long long maxScore(int** intervals, int intervalsSize, int* intervalsColSize) {
    if (intervalsSize == 0) {
        return 0;
    }

    // Convert input int** to our Interval struct array for easier handling
    Interval *ivs = (Interval*)malloc(intervalsSize * sizeof(Interval));
    if (ivs == NULL) {
        return 0; 
    }

    for (int i = 0; i < intervalsSize; ++i) {
        ivs[i].start = intervals[i][0];
        ivs[i].end = intervals[i][1];
        ivs[i].score = intervals[i][2];
    }

    // Sort intervals by their end times
    qsort(ivs, intervalsSize, sizeof(Interval), compareIntervals);

    // dp[i] will store the maximum score achievable considering intervals up to index i (inclusive)
    long long *dp = (long long*)calloc(intervalsSize, sizeof(long long));
    if (dp == NULL) {
        free(ivs);
        return 0; 
    }

    // Base case: For the first interval, the max score is its own score
    dp[0] = ivs[0].score;

    // Fill the DP table
    for (int i = 1; i < intervalsSize; ++i) {
        // Option 1: Do not include the current interval (ivs[i])
        // The max score is simply the max score up to the previous interval
        long long scoreWithoutCurrent = dp[i-1];

        // Option 2: Include the current interval (ivs[i])
        // We need to find the maximum score from a non-overlapping preceding interval
        long long scoreWithCurrent = ivs[i].score; // Start with the current interval's score
        int prevIndex = findPrecedingInterval(ivs, intervalsSize, i);
        if (prevIndex != -1) {
            // If a non-overlapping preceding interval exists, add its max score
            scoreWithCurrent += dp[prevIndex];
        }

        // Take the maximum of the two options
        dp[i] = (scoreWithoutCurrent > scoreWithCurrent) ? scoreWithoutCurrent : scoreWithCurrent;
    }

    // The maximum score will be in the last element of the dp array
    long long result = dp[intervalsSize - 1];

    // Free dynamically allocated memory
    free(ivs);
    free(dp);

    return result;
}