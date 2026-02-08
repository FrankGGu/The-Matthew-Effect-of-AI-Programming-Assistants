#include <stdlib.h>
#include <limits.h>

int cmp(const void* a, const void* b) {
    long long* pa = (long long*)a;
    long long* pb = (long long*)b;
    if (pa[0] == pb[0]) {
        if (pa[1] < pb[1]) return -1;
        return 1;
    }
    if (pa[0] < pb[0]) return -1;
    return 1;
}

int minimizeBatteryUsage(int numComponents, int** powerSources, int powerSourcesSize, int* powerSourcesColSize) {
    long long** events = (long long**)malloc(2 * numComponents * sizeof(long long*));
    for (int i = 0; i < 2 * numComponents; i++) {
        events[i] = (long long*)malloc(2 * sizeof(long long));
    }

    int idx = 0;
    for (int i = 0; i < numComponents; i++) {
        long long start = powerSources[i][0];
        long long end = powerSources[i][1];
        events[idx][0] = start;
        events[idx][1] = 1;
        idx++;
        events[idx][0] = end + 1;
        events[idx][1] = -1;
        idx++;
    }

    qsort(events, 2 * numComponents, sizeof(events[0]), cmp);

    long long max_power = 0;
    long long current_power = 0;
    long long last_time = events[0][0];

    for (int i = 0; i < 2 * numComponents; i++) {
        long long time = events[i][0];
        long long type = events[i][1];

        if (time > last_time) {
            long long power_needed = current_power * (time - last_time);
            if (power_needed > max_power) {
                max_power = power_needed;
            }
            last_time = time;
        }

        current_power += type;
    }

    for (int i = 0; i < 2 * numComponents; i++) {
        free(events[i]);
    }
    free(events);

    return max_power % 1000000007;
}