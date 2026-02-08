#include <stdbool.h>

bool check(long long max_time, int* dishes, int dishesSize, int k) {
    int cooks_needed = 1;
    long long current_cook_time = 0;

    for (int i = 0; i < dishesSize; ++i) {
        // If a single dish takes longer than the allowed max_time, it's impossible
        if (dishes[i] > max_time) {
            return false;
        }

        // Try to add the current dish to the current cook's schedule
        if (current_cook_time + dishes[i] <= max_time) {
            current_cook_time += dishes[i];
        } else {
            // Current cook cannot take this dish, assign it to a new cook
            cooks_needed++;
            current_cook_time = dishes[i]; // New cook starts with this dish
        }
    }

    // Check if the number of cooks required is within the limit
    return cooks_needed <= k;
}

int minTime(int* dishes, int dishesSize, int k) {
    long long left = 0;  // Minimum possible time: time for the longest single dish
    long long right = 0; // Maximum possible time: sum of all dish times (if k=1)

    for (int i = 0; i < dishesSize; ++i) {
        if (dishes[i] > left) {
            left = dishes[i];
        }
        right += dishes[i];
    }

    long long ans = right; // Initialize answer with the worst-case maximum time

    // Binary search for the minimum possible max_time
    while (left <= right) {
        long long mid = left + (right - left) / 2; // Calculate mid to avoid overflow

        if (check(mid, dishes, dishesSize, k)) {
            // If it's possible to cook all dishes within 'mid' time,
            // 'mid' is a potential answer. Try to find a smaller time.
            ans = mid;
            right = mid - 1;
        } else {
            // If it's not possible, 'mid' time is too small.
            // We need more time.
            left = mid + 1;
        }
    }

    return (int)ans; // Cast to int as per function signature
}