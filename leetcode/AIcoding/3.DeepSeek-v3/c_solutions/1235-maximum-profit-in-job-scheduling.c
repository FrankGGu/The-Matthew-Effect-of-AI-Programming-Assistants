#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
    int profit;
} Job;

int cmp(const void* a, const void* b) {
    Job* jobA = (Job*)a;
    Job* jobB = (Job*)b;
    return jobA->end - jobB->end;
}

int binarySearch(Job* jobs, int right, int target) {
    int left = 0;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (jobs[mid].end <= target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return right;
}

int jobScheduling(int* startTime, int startTimeSize, int* endTime, int endTimeSize, int* profit, int profitSize) {
    int n = startTimeSize;
    Job* jobs = (Job*)malloc(n * sizeof(Job));
    for (int i = 0; i < n; i++) {
        jobs[i].start = startTime[i];
        jobs[i].end = endTime[i];
        jobs[i].profit = profit[i];
    }

    qsort(jobs, n, sizeof(Job), cmp);

    int* dp = (int*)malloc(n * sizeof(int));
    dp[0] = jobs[0].profit;

    for (int i = 1; i < n; i++) {
        int currentProfit = jobs[i].profit;
        int idx = binarySearch(jobs, i - 1, jobs[i].start);
        if (idx != -1) {
            currentProfit += dp[idx];
        }
        dp[i] = (currentProfit > dp[i-1]) ? currentProfit : dp[i-1];
    }

    int result = dp[n-1];
    free(jobs);
    free(dp);
    return result;
}