#include <stdlib.h> // For qsort
#include <limits.h> // For LLONG_MAX

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long min_ll(long long a, long long b) {
    return a < b ? a : b;
}

long long calculate_cost(long long target, int* nums, int numsSize, int cost1, int cost2) {
    long long sum_diff = 0; // Total increments needed across all elements
    long long max_diff = 0; // Maximum increments needed for any single element

    for (int i = 0; i < numsSize; i++) {
        long long diff = target - nums[i];
        sum_diff += diff;
        if (diff > max_diff) {
            max_diff = diff;
        }
    }

    // If 2 * cost1 is less than or equal to cost2, it's always optimal to use cost1 for every single increment.
    // This is because using cost2 to increment two elements is equivalent to using two cost1 operations,
    // and if 2*cost1 is cheaper or equal, we effectively treat all increments as costing cost1.
    if ((long long)2 * cost1 <= cost2) {
        return sum_diff * cost1;
    } else {
        // We prefer using cost2 operations because 2 * cost1 > cost2.
        // We need to determine how many increments are done by cost1 and how many by cost2.
        //
        // Let num_cost1_ops be the number of single increments (cost1).
        // Let num_cost2_ops be the number of double increments (cost2).
        // Total increments needed is sum_diff. Each cost2 operation uses 2 increments.
        //
        // Case 1: max_diff * 2 <= sum_diff
        // No single element needs more than half of the total increments.
        // We can pair up as many increments as possible using cost2 operations.
        // The number of cost2 operations will be sum_diff / 2.
        // The number of cost1 operations will be sum_diff % 2 (if sum_diff is odd, one increment remains).
        //
        // Case 2: max_diff * 2 > sum_diff
        // One element (the one needing max_diff increments) needs more than half of the total increments.
        // It's impossible to pair up all its increments.
        // The other elements combined need (sum_diff - max_diff) increments.
        // We can pair up all these (sum_diff - max_diff) increments with the max_diff element.
        // So, we use (sum_diff - max_diff) cost2 operations.
        // After these operations, the max_diff element still needs:
        // max_diff - (sum_diff - max_diff) = 2 * max_diff - sum_diff increments.
        // These remaining increments must be done using cost1 operations.
        //
        long long num_cost1_ops;
        long long num_cost2_ops;

        if (max_diff * 2 <= sum_diff) {
            num_cost1_ops = sum_diff % 2;
            num_cost2_ops = sum_diff / 2;
        } else { // max_diff * 2 > sum_diff
            num_cost1_ops = 2 * max_diff - sum_diff;
            num_cost2_ops = sum_diff - max_diff;
        }
        return num_cost2_ops * cost2 + num_cost1_ops * cost1;
    }
}

long long minCostToEqualizeArray(int* nums, int numsSize, int cost1, int cost2) {
    qsort(nums, numsSize, sizeof(int), compare);

    long long min_val_initial = nums[0];
    long long max_val_initial = nums[numsSize - 1];

    if (numsSize == 1) {
        return 0; // If only one element, no cost to equalize.
    }

    // Ternary search for the optimal target value.
    // The cost function is convex, allowing ternary search to find the minimum.
    long long low = max_val_initial;
    // A robust upper bound for the target.
    // It covers cases where array elements are far apart (e.g., 1 and 10^9)
    // and cases where `numsSize` is large and `cost2` is very cheap, requiring a higher target.
    // Max `nums[i]` is 10^9. Max `numsSize` is 10^5.
    // `2LL * (max_val_initial - min_val_initial)` covers the maximum possible difference between elements.
    // `2LL * numsSize` accounts for scenarios where a higher target is beneficial due to `cost2` efficiency.
    long long high = max_val_initial + 2LL * (max_val_initial - min_val_initial) + 2LL * numsSize;

    long long ans = LLONG_MAX;

    // Ternary search loop
    // The loop continues until the search range is small enough to check all remaining values directly.
    while (low <= high) {
        if (high - low < 3) { 
            for (long long t = low; t <= high; ++t) {
                ans = min_ll(ans, calculate_cost(t, nums, numsSize, cost1, cost2));
            }
            break;
        }

        long long m1 = low + (high - low) / 3;
        long long m2 = high - (high - low) / 3;

        long long cost_m1 = calculate_cost(m1, nums, numsSize, cost1, cost2);
        long long cost_m2 = calculate_cost(m2, nums, numsSize, cost1, cost2);

        ans = min_ll(ans, cost_m1);
        ans = min_ll(ans, cost_m2);

        if (cost_m1 < cost_m2) {
            high = m2 - 1; // Minimum is in the left two-thirds
        } else {
            low = m1 + 1;  // Minimum is in the right two-thirds
        }
    }

    return ans;
}