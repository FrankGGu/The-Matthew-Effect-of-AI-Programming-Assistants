#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int backtrack(int* jobs, int n, int* power, int k, int idx, int maxTime) {
    if (idx == n) {
        return maxTime;
    }

    int minTime = INT_MAX;
    for (int i = 0; i < k; i++) {
        if (power[i] + jobs[idx] > maxTime) continue;
        power[i] += jobs[idx];
        minTime = fmin(minTime, backtrack(jobs, n, power, k, idx + 1, maxTime));
        power[i] -= jobs[idx];
        if (minTime != INT_MAX) break;
    }
    return minTime;
}

int minimumTimeRequired(int* jobs, int jobsSize, int k) {
    qsort(jobs, jobsSize, sizeof(int), compare);
    int* power = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        power[i] = 0;
    }
    return backtrack(jobs, jobsSize, power, k, 0, INT_MAX);
}