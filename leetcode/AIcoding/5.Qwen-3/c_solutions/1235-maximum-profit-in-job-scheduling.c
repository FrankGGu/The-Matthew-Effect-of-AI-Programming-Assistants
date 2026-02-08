#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int start;
    int end;
    int profit;
} Job;

int compare(const void* a, const void* b) {
    return ((Job*)a)->end - ((Job*)b)->end;
}

int findLastNonConflicting(int* dp, Job* jobs, int n, int index) {
    int low = 0, high = index - 1;
    while (low <= high) {
        int mid = (low + high) / 2;
        if (jobs[mid].end <= jobs[index].start) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return high;
}

int jobScheduling(Job* jobs, int jobsSize) {
    qsort(jobs, jobsSize, sizeof(Job), compare);
    int* dp = (int*)malloc(jobsSize * sizeof(int));
    for (int i = 0; i < jobsSize; i++) {
        dp[i] = jobs[i].profit;
    }
    for (int i = 1; i < jobsSize; i++) {
        int prev = findLastNonConflicting(dp, jobs, jobsSize, i);
        if (prev != -1) {
            dp[i] = (dp[i] > dp[prev]) ? dp[i] : dp[prev];
        }
    }
    int maxProfit = 0;
    for (int i = 0; i < jobsSize; i++) {
        if (dp[i] > maxProfit) {
            maxProfit = dp[i];
        }
    }
    free(dp);
    return maxProfit;
}