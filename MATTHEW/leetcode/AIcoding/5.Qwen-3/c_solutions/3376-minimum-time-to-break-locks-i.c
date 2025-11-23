#include <stdio.h>
#include <stdlib.h>

int minTimeToBreakLocks(int* locks, int locksSize, int k) {
    int* times = (int*)malloc(locksSize * sizeof(int));
    for (int i = 0; i < locksSize; i++) {
        times[i] = 0;
    }

    for (int i = 0; i < locksSize; i++) {
        int lock = locks[i];
        int time = 0;
        while (lock > 0) {
            lock /= 10;
            time++;
        }
        times[i] = time;
    }

    qsort(times, locksSize, sizeof(int), (int (*)(const void*, const void*))strcmp);

    int total = 0;
    for (int i = 0; i < k; i++) {
        total += times[i];
    }

    free(times);
    return total;
}