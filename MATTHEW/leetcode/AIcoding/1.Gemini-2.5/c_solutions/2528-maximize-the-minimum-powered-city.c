#include <stdlib.h> // For max/min (or define them)
#include <string.h> // For memset
#include <stdbool.h> // For bool type

#ifndef max
#define max(a,b) ((a) > (b) ? (a) : (b))
#endif
#ifndef min
#define min(a,b) ((a) < (b) ? (a) : (b))
#endif

bool check(long long target_min_power, int n, int r, long long k, long long* initial_power_values) {
    // Create a mutable copy of initial power values for calculation
    // Variable Length Array (VLA) `current_power[n]` is a C99 feature.
    long long current_power[n]; 
    for (int i = 0; i < n; ++i) {
        current_power[i] = initial_power_values[i];
    }

    // Difference array to track power added by new stations
    // diff_added_stations[j] stores the net change in added power starting at city j.
    // Size n+1 to handle potential index n for subtraction.
    long long diff_added_stations[n + 1];
    memset(diff_added_stations, 0, sizeof(long long) * (n + 1));

    long long stations_used = 0;
    long long current_added_power_from_stations = 0; // Cumulative power from new stations up to current city

    for (int i = 0; i < n; ++i) {
        // Apply the effect of stations whose range starts or ends at city 'i'
        current_added_power_from_stations += diff_added_stations[i];

        long long total_power_at_i = current_power[i] + current_added_power_from_stations;

        // If current city 'i' does not meet the target_min_power, add stations
        if (total_power_at_i < target_min_power) {
            long long needed = target_min_power - total_power_at_i;

            stations_used += needed;
            // If we exceed the allowed 'k' stations, this target_min_power is not achievable
            if (stations_used > k) {
                return false;
            }

            // Add the 'needed' power to current_added_power_from_stations.
            // This power starts affecting cities from 'i'.
            current_added_power_from_stations += needed;

            // These 'needed' stations are conceptually placed at city 'i + r'.
            // A station at 'j' affects cities in range [j-r, j+r].
            // To cover city 'i' and maximize reach to the right, we place stations at 'i + r'.
            // These stations will affect cities from (i+r)-r = i to (i+r)+r = i+2r.
            // So, the added power from these 'needed' stations will stop affecting cities after 'i + 2 * r'.
            // We mark this by subtracting 'needed' at index 'i + 2 * r + 1' in the difference array.
            if (i + 2 * r + 1 < n) {
                diff_added_stations[i + 2 * r + 1] -= needed;
            }
        }
    }
    return true; // All cities meet the target_min_power with <= k stations
}

long long maximizeTheMinimumPoweredCity(int* powers, int powersSize, int r, long long k) {
    int n = powersSize;

    // 1. Calculate the initial power for each city
    // The power of city 'j' is the sum of powers[i] for i in [max(0, j-r), min(n-1, j+r)]
    // This can be efficiently calculated using a sliding window sum.
    long long initial_power_values[n]; // VLA
    long long current_window_sum = 0;

    // Calculate initial power for city 0
    // Window for city 0 is [0, min(n-1, r)]
    for (int i = 0; i <= r && i < n; ++i) {
        current_window_sum += powers[i];
    }
    initial_power_values[0] = current_window_sum;

    // Calculate initial power for cities 1 to n-1 by sliding the window
    for (int i = 1; i < n; ++i) {
        // Add the new element entering the window from the right
        if (i + r < n) {
            current_window_sum += powers[i + r];
        }
        // Remove the element leaving the window from the left
        if (i - r - 1 >= 0) {
            current_window_sum -= powers[i - r - 1];
        }
        initial_power_values[i] = current_window_sum;
    }

    // 2. Binary search for the maximum possible minimum power
    long long low = 0;
    // Maximum possible power for a city:
    // Initial max power (n * max_powers_val) + max_k_stations.
    // n=10^5, powers[i]=10^9 => 10^14. k=10^9.
    // So, roughly 10^14 + 10^9. A safe upper bound is 2 * 10^14.
    long long high = 200000000000000LL; 
    long long ans = 0;

    while (low <= high) {
        long long mid = low + (high - low) / 2;
        if (check(mid, n, r, k, initial_power_values)) {
            ans = mid;      // 'mid' is achievable, try for a higher minimum power
            low = mid + 1;
        } else {
            high = mid - 1; // 'mid' is not achievable, try for a lower minimum power
        }
    }

    return ans;
}