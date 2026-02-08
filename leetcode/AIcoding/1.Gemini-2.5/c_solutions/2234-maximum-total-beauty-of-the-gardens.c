#include <stdlib.h> // For qsort
#include <stdio.h>  // For NULL, though not strictly needed for LeetCode environment
#include <math.h>   // For fmax, though a ternary operator is used to avoid floating point

int compareIntegers(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

long long find_max_min_beauty_for_target(int* gardens, int n, int target, long long newFlowers) {
    long long low;

    // Determine the lower bound for binary search on min_beauty.
    // If there are gardens that must be partial (n - target > 0),
    // then min_beauty must be strictly greater than the largest beauty among these partial gardens.
    // These gardens are gardens[0]...gardens[n-target-1] after sorting.
    // So, min_beauty must be > gardens[n-target-1].
    if (n - target > 0) {
        low = (long long)gardens[n - target - 1] + 1;
    } else {
        // If all gardens are full (target == n), there are no mandatory partial gardens.
        // In this case, min_beauty can be 0 (or even negative, but 0 is the practical minimum).
        low = 0;
    }

    // Determine the upper bound for binary search on min_beauty.
    // The maximum possible beauty a garden can achieve is its current beauty plus all available flowers.
    // So, min_beauty cannot exceed the maximum garden's beauty plus newFlowers, plus one
    // (to allow for the possibility of min_beauty being just above the max achievable beauty).
    long long high = (long long)gardens[n-1] + newFlowers + 1;

    // Initialize ans_min_beauty with the lowest possible valid min_beauty.
    // This handles cases where even the minimum required min_beauty is too costly.
    long long ans_min_beauty = low; 

    // Binary search to find the maximum min_beauty achievable within the budget
    while (low <= high) {
        long long mid = low + (high - low) / 2;
        long long cost = 0;

        // Calculate the cost to make the 'target' gardens complete.
        // To minimize cost, these will be the 'target' gardens with the highest initial beauty.
        // These are gardens[n-target]...gardens[n-1] after sorting.
        int start_idx_for_full = n - target;
        for (int i = start_idx_for_full; i < n; ++i) {
            // Only add cost if the desired min_beauty (mid) is greater than the garden's current beauty.
            // Using ternary operator instead of fmax to avoid floating point issues.
            cost += (mid > gardens[i] ? mid - gardens[i] : 0LL);
        }

        // If the calculated cost is within the budget, this 'mid' min_beauty is achievable.
        // Try for a higher min_beauty.
        if (cost <= newFlowers) {
            ans_min_beauty = mid;
            low = mid + 1;
        } else {
            // If the cost exceeds the budget, 'mid' min_beauty is too high.
            // Try for a lower min_beauty.
            high = mid - 1;
        }
    }
    return ans_min_beauty;
}

long long maximumTotalBeauty(int* gardens, int gardensSize, long long newFlowers, int target, int fullBeauty, int partialBeauty) {
    int n = gardensSize;

    // Sort the gardens array in ascending order. This is crucial for the binary search logic.
    qsort(gardens, n, sizeof(int), compareIntegers);

    // The problem statement specifies 1 <= target <= n.
    // This means target will always be at least 1, and at most n.
    // Therefore, we don't need to handle target == 0 separately.

    // Find the maximum possible min_beauty that can be achieved given the constraints.
    long long max_min_beauty = find_max_min_beauty_for_target(gardens, n, target, newFlowers);

    // Calculate the total beauty using the found max_min_beauty.
    // The number of full gardens is 'target'.
    // The number of partial gardens is 'n - target'.
    // The 'partialBeauty' parameter in the function signature is unused, as per the problem description
    // "total beauty ... full * fullBeauty + partial * min_beauty", where min_beauty is a chosen variable.
    long long total_beauty = (long long)target * fullBeauty + (long long)(n - target) * max_min_beauty;

    return total_beauty;
}