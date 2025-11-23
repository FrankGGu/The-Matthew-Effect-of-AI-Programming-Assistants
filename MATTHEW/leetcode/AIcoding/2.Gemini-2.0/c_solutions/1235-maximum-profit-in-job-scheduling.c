#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
    int profit;
} Job;

int compareJobs(const void *a, const void *b) {
    return ((Job *)a)->end - ((Job *)b)->end;
}

int binarySearch(Job jobs[], int n, int target) {
    int low = 0, high = n - 1;
    int result = -1;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (jobs[mid].end <= target) {
            result = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return result;
}

int jobScheduling(int* startTime, int startTimeSize, int* endTime, int endTimeSize, int* profit, int profitSize) {
    int n = startTimeSize;
    Job jobs[n];
    for (int i = 0; i < n; i++) {
        jobs[i].start = startTime[i];
        jobs[i].end = endTime[i];
        jobs[i].profit = profit[i];
    }

    qsort(jobs, n, sizeof(Job), compareJobs);

    int dp[n];
    dp[0] = jobs[0].profit;

    for (int i = 1; i < n; i++) {
        int currentProfit = jobs[i].profit;
        int prevJobIndex = binarySearch(jobs, i, jobs[i].start);

        if (prevJobIndex != -1) {
            currentProfit += dp[prevJobIndex];
        }

        dp[i] = (currentProfit > dp[i - 1]) ? currentProfit : dp[i - 1];
    }

    return dp[n - 1];
}