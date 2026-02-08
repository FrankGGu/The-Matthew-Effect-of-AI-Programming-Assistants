#include <stdlib.h>

int upper_bound(int* arr, int size, int target) {
    int low = 0;
    int high = size;
    while (low < high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] <= target) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return low;
}

int* longestObstacleCourseAtEachPosition(int* obstacles, int obstaclesSize, int* returnSize) {
    int* result = (int*)malloc(obstaclesSize * sizeof(int));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int* tails = (int*)malloc(obstaclesSize * sizeof(int));
    if (tails == NULL) {
        free(result);
        *returnSize = 0;
        return NULL;
    }

    int len = 0; // Current length of the 'tails' array

    for (int i = 0; i < obstaclesSize; ++i) {
        int obstacle = obstacles[i];

        // Find the insertion point for 'obstacle' in 'tails'
        // 'pos' will be the index of the first element in 'tails' that is strictly greater than 'obstacle'.
        // If all elements in 'tails' are less than or equal to 'obstacle', 'pos' will be 'len'.
        int pos = upper_bound(tails, len, obstacle);

        if (pos == len) {
            // 'obstacle' is greater than or equal to all elements in 'tails'.
            // It extends the longest non-decreasing subsequence found so far.
            tails[len] = obstacle;
            len++;
        } else {
            // 'obstacle' is smaller than tails[pos].
            // We can form a non-decreasing subsequence of length (pos + 1) with a smaller ending element.
            // This is beneficial for future extensions, as it allows more numbers to follow.
            tails[pos] = obstacle;
        }

        // The length of the longest non-decreasing subsequence ending at obstacles[i]
        // is (pos + 1), because 'pos' is a 0-based index.
        result[i] = pos + 1;
    }

    *returnSize = obstaclesSize;
    free(tails);
    return result;
}