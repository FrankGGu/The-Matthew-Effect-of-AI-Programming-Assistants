#include <stdbool.h>
#include <stdlib.h>
#include <string.h> // For memset

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

bool canPartition(int* nums, int numsSize, bool* visited, int k, int targetSum, int currentSum, int startIdx) {
    // Base case 1: If all k subsets have been successfully formed
    if (k == 0) {
        return true;
    }

    // Base case 2: If the current subset's sum equals the target sum
    // We have successfully formed one subset. Now, try to form the remaining k-1 subsets.
    if (currentSum == targetSum) {
        // Reset currentSum to 0 and startIdx to 0 for building the next subset
        return canPartition(nums, numsSize, visited, k - 1, targetSum, 0, 0);
    }

    // Recursive step: Try to add numbers to the current subset
    for (int i = startIdx; i < numsSize; i++) {
        // Pruning:
        // 1. If nums[i] has already been used in another subset or the current one.
        // 2. If adding nums[i] exceeds the target sum for the current subset.
        if (visited[i] || currentSum + nums[i] > targetSum) {
            continue;
        }

        // Optimization for duplicate numbers when starting a new subset:
        // If currentSum is 0 (meaning we are starting a new subset) AND
        // this number is the same as the previous number AND
        // the previous number was NOT visited (meaning trying to start a subset with nums[i-1] failed),
        // then trying to start a subset with nums[i] will also fail in the same way.
        // This avoids redundant computations for identical starting points of new subsets.
        if (currentSum == 0 && i > 0 && nums[i] == nums[i-1] && !visited[i-1]) {
            continue;
        }

        visited[i] = true; // Mark nums[i] as used

        // Recursively call to add more numbers to the current subset
        // We pass i + 1 as startIdx to ensure numbers are picked in increasing order of index
        // within a subset and to avoid reusing the same number.
        if (canPartition(nums, numsSize, visited, k, targetSum, currentSum + nums[i], i + 1)) {
            return true; // If a solution is found down this path, propagate true
        }

        visited[i] = false; // Backtrack: unmark nums[i] as unused for other possibilities
    }

    // If no number could be added to form a valid subset from this state, return false
    return false;
}

bool canPartitionKSubsets(int* nums, int numsSize, int k) {
    // Edge cases:
    // If k is non-positive or there are fewer numbers than subsets, it's impossible.
    if (k <= 0 || numsSize < k) {
        return false;
    }

    int totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    // If the total sum is not perfectly divisible by k, it's impossible to form equal sum subsets.
    if (totalSum % k != 0) {
        return false;
    }

    int targetSum = totalSum / k;

    // Sort nums in descending order. This helps in pruning branches faster during backtracking
    // by trying larger numbers first, which are more likely to quickly reach the target sum or exceed it.
    qsort(nums, numsSize, sizeof(int), compare);

    // If any single number is greater than the target sum, it's impossible to form a subset with it.
    // This check is more effective after sorting as the largest number is nums[0].
    if (nums[0] > targetSum) {
        return false;
    }

    // Allocate and initialize the visited array.
    // It keeps track of which numbers have been used across all subsets.
    bool* visited = (bool*)malloc(sizeof(bool) * numsSize);
    if (visited == NULL) {
        // Handle memory allocation failure (though LeetCode typically guarantees success)
        return false;
    }
    memset(visited, 0, sizeof(bool) * numsSize); // Initialize all elements to false

    // Start the backtracking process
    bool result = canPartition(nums, numsSize, visited, k, targetSum, 0, 0);

    free(visited); // Free the dynamically allocated memory
    return result;
}