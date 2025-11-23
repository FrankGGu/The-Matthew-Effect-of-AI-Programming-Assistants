#include <stdbool.h> // Required for bool type

long long canAllocate(int x, int* candies, int candiesSize, long long k) {
    if (x == 0) {
        // If 0 candies per child is allowed, we can always satisfy k children
        // (as long as k is non-negative, which it is by constraints).
        // This is the base case for the lowest possible candy amount.
        return true;
    }

    long long children_count = 0;
    for (int i = 0; i < candiesSize; i++) {
        children_count += (long long)candies[i] / x;
        // Optimization: if we already have enough children, no need to count further
        if (children_count >= k) {
            return true;
        }
    }
    return children_count >= k;
}

int maximumCandies(int* candies, int candiesSize, long long k) {
    int low = 0;
    // The maximum possible candy value for a single pile is 10^9.
    // So, the maximum possible candies per child cannot exceed this.
    int high = 1000000000; 
    int ans = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;

        if (canAllocate(mid, candies, candiesSize, k)) {
            // If it's possible to allocate 'mid' candies per child,
            // then 'mid' is a possible answer. We try to find a larger one.
            ans = mid;
            low = mid + 1;
        } else {
            // If it's not possible to allocate 'mid' candies per child,
            // we need to try with fewer candies.
            high = mid - 1;
        }
    }

    return ans;
}