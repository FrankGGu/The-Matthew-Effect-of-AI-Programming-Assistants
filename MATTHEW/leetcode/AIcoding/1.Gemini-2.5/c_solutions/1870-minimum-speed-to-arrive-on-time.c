#include <stdbool.h> // For bool type

bool check(int speed, int* dist, int distSize, double hour) {
    double total_time = 0.0;

    // Calculate time for the first distSize - 1 trains
    // For these trains, we must wait until the next whole hour if we arrive early.
    for (int i = 0; i < distSize - 1; ++i) {
        // Time taken for each segment (except the last one) is ceil(dist[i] / speed)
        // Using integer division for ceil(a/b) for positive a, b: (a + b - 1) / b
        total_time += (double)((dist[i] + speed - 1) / speed);
    }

    // Calculate time for the last train
    // For the last train, there's no need to wait, so it's just dist[last] / speed.
    total_time += (double)dist[distSize - 1] / speed;

    return total_time <= hour;
}

int minSpeedOnTime(int* dist, int distSize, double hour) {
    int low = 1;
    // A sufficiently large upper bound for speed.
    // Max dist[i] is 10^5, max n is 10^5.
    // If n=1 and dist[0]=10^5 and hour=1e-7, speed could be 10^5 / 1e-7 = 10^12.
    // However, speed must fit in an int. Max int is approx 2 * 10^9.
    // So, 2 * 10^9 is a safe upper bound for the binary search.
    int high = 2000000000; 
    int ans = -1; // Initialize answer to -1 (no possible speed found)

    // Binary search for the minimum possible integer speed
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (check(mid, dist, distSize, hour)) {
            ans = mid;         // This speed is possible, try for a smaller one
            high = mid - 1;
        } else {
            low = mid + 1;     // This speed is too slow, need a faster one
        }
    }

    return ans;
}