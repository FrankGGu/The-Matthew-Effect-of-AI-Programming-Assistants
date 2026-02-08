#include <stdbool.h>
#include <stddef.h>

bool check(long long time, int n, int* batteries, int batteriesSize) {
    if (time == 0) {
        return true;
    }

    long long total_power_available = 0;
    for (int i = 0; i < batteriesSize; i++) {
        total_power_available += (batteries[i] < time) ? batteries[i] : time;
    }

    return total_power_available >= (long long)n * time;
}

long long maxRunTime(int n, int* batteries, int batteriesSize) {
    long long low = 0;
    long long high = 0;

    for (int i = 0; i < batteriesSize; i++) {
        high += batteries[i];
    }
    high /= n;

    long long ans = 0;

    while (low <= high) {
        long long mid = low + (high - low) / 2;

        if (check(mid, n, batteries, batteriesSize)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
}