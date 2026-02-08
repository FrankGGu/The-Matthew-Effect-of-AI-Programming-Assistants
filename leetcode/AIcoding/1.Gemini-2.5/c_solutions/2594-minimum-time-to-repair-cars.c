#include <stdbool.h>
#include <math.h>

bool check(long long time, int* ranks, int ranksSize, int cars) {
    long long carsRepaired = 0;
    for (int i = 0; i < ranksSize; i++) {
        long long rank = ranks[i];
        // The number of cars 'n' a mechanic with rank 'r' can repair in 'time' is
        // r * n * n <= time
        // n * n <= time / r
        // n <= sqrt(time / r)
        // We use (double) for division before sqrt to maintain precision, then cast to long long
        long long numCarsForThisMechanic = (long long)sqrt((double)time / rank);
        carsRepaired += numCarsForThisMechanic;
        if (carsRepaired >= cars) {
            return true; // Optimization: if we already have enough cars, no need to check further
        }
    }
    return carsRepaired >= cars;
}

long long minTimeToRepairCars(int* ranks, int ranksSize, int cars) {
    long long low = 1; // Minimum possible time is 1 (1 car, rank 1, time 1*1*1=1)

    // Maximum possible time:
    // If one mechanic with the highest possible rank (100) has to repair all cars (10^5).
    // Time = 100 * (10^5)^2 = 100 * 10^10 = 10^12.
    // Using 10^12 as a safe upper bound for binary search.
    long long high = 100LL * 100000LL * 100000LL; 

    long long ans = high; // Initialize answer with the maximum possible time

    while (low <= high) {
        long long mid = low + (high - low) / 2;
        if (check(mid, ranks, ranksSize, cars)) {
            ans = mid;         // 'mid' is a possible time, try for a smaller time
            high = mid - 1;
        } else {
            low = mid + 1;     // 'mid' is not enough, need more time
        }
    }

    return ans;
}