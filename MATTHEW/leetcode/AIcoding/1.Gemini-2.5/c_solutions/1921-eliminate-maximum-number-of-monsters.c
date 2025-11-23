#include <stdlib.h> // For malloc, qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int eliminateMaximumMonsters(int* dist, int distSize, int* speed, int speedSize) {
    int n = distSize;

    int* arrival_times = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        arrival_times[i] = (dist[i] + speed[i] - 1) / speed[i];
    }

    qsort(arrival_times, n, sizeof(int), compare);

    for (int i = 0; i < n; i++) {
        if (arrival_times[i] <= i) {
            free(arrival_times);
            return i;
        }
    }

    free(arrival_times);
    return n;
}