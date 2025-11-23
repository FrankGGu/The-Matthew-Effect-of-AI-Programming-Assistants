#include <stdbool.h>

bool check(long long n, long long* batteries, int batteriesSize, long long time) {
    if (time == 0) {
        return true;
    }

    long long computers_powered_by_full_batteries = 0;
    long long extra_power_pool = 0;

    for (int i = 0; i < batteriesSize; i++) {
        if (batteries[i] >= time) {
            computers_powered_by_full_batteries++;
        } else {
            extra_power_pool += batteries[i];
        }
    }

    if (computers_powered_by_full_batteries >= n) {
        return true;
    }

    long long needed_computers = n - computers_powered_by_full_batteries;

    return extra_power_pool / time >= needed_computers;
}

long long maxRunTime(long long n, long long* batteries, int batteriesSize) {
    long long total_battery_sum = 0;
    for (int i = 0; i < batteriesSize; i++) {
        total_battery_sum += batteries[i];
    }

    long long low = 0;
    long long high = total_battery_sum / n;
    long long ans = 0;

    while (low <= high) {
        long long mid = low + (high - low) / 2;
        if (check(n, batteries, batteriesSize, mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
}