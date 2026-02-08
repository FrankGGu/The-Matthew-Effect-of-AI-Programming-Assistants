#include <stdlib.h>

typedef struct {
    int start;
    int end;
    int profit;
} Job;

int cmp(const void *a, const void *b) {
    return ((Job *)a)->end - ((Job *)b)->end;
}

int binarySearch(Job* jobs, int index) {
    int low = 0, high = index - 1;
    while (low <= high) {
        int mid = (low + high) / 2;
        if (jobs[mid].end < jobs[index].start) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return high;
}

int jobScheduling(int* startTime, int* endTime, int* profit, int size) {
    Job* jobs = (Job *)malloc(sizeof(Job) * size);
    for (int i = 0; i < size; i++) {
        jobs[i].start = startTime[i];
        jobs[i].end = endTime[i];
        jobs[i].profit = profit[i];
    }

    qsort(jobs, size, sizeof(Job), cmp);

    int* dp = (int *)malloc(sizeof(int) * size);
    dp[0] = jobs[0].profit;

    for (int i = 1; i < size; i++) {
        int inclProfit = jobs[i].profit;
        int l = binarySearch(jobs, i);
        if (l != -1) inclProfit += dp[l];
        dp[i] = fmax(inclProfit, dp[i - 1]);
    }

    int result = dp[size - 1];
    free(jobs);
    free(dp);
    return result;
}