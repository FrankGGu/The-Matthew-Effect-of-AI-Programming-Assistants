#include <stdlib.h> // Required for qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long maximizeTheMinimumGameScore(int* nums, int numsSize) {
    // Sort the array in ascending order.
    // This is crucial because to maximize the minimum of two sums,
    // we want to make the two sums as close as possible.
    // In this game, for each pair of selected elements (x, y),
    // the current player gets min(x, y) and the friend gets max(x, y).
    // To minimize the difference between the total scores, we should pair adjacent elements
    // from the sorted array.
    // For example, if sorted array is [n0, n1, n2, n3, ...],
    // we form pairs (n0, n1), (n2, n3), etc.
    // The current player takes n0, n2, ... (elements at even indices).
    // The friend takes n1, n3, ... (elements at odd indices).
    qsort(nums, numsSize, sizeof(int), compare);

    long long myScore = 0;
    long long friendScore = 0;

    // Iterate through the sorted array and sum elements based on their index parity
    for (int i = 0; i < numsSize; ++i) {
        if (i % 2 == 0) {
            // Elements at even indices go to the current player (these are the smaller elements in each pair)
            myScore += nums[i];
        } else {
            // Elements at odd indices go to the friend (these are the larger elements in each pair)
            friendScore += nums[i];
        }
    }

    // Return the minimum of the two scores
    // This represents the maximum possible value for the minimum score achievable
    return myScore < friendScore ? myScore : friendScore;
}