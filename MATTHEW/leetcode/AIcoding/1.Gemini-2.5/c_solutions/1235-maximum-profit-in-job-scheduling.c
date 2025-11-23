#include <stdlib.h>

typedef struct {
    int start;
    int end;
    int profit;
} Job;

int compareJobs(const void *a, const void *b) {
    Job *jobA = (Job *)a;
    Job *jobB = (Job *)b;
    if (jobA->end != jobB->end) {
        return jobA->end - jobB->end;
    }
    return jobA->start - jobB->start;
}

int findLatestNonConflictingJob(Job *jobs, int n, int current_job_start_time) {
    int low = 0;
    int high = n - 1;
    int ans = -1;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (jobs[mid].end <= current_job_start_time) {
            ans = mid;
            low = mid + 1; // Try to find a later non-conflicting job
        } else {
            high = mid - 1; // This job conflicts, look earlier
        }
    }
    return ans;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int jobScheduling(int* startTime, int startTimeSize, int* endTime, int endTimeSize, int* profit, int profitSize) {
    int n = startTimeSize;
    Job jobs[n];
    for (int i = 0; i < n; i++) {
        jobs[i].start = startTime[i];
        jobs[i].end = endTime[i];
        jobs[i].profit = profit[i];
    }

    // Sort jobs by their end times
    qsort(jobs, n, sizeof(Job), compareJobs);

    // dp[i] will store the maximum profit considering jobs[0...i-1]
    // dp array is 1-indexed conceptually for jobs, so dp[0] is for 0 jobs, dp[1] for jobs[0], etc.
    // Size n+1 to accommodate dp[n] for the result of all n jobs.
    int* dp = (int*)calloc(n + 1, sizeof(int)); // dp[0] = 0 (base case: no jobs, no profit)

    for (int i = 0; i < n; i++) {
        // Option 1: Don't take the current job (jobs[i])
        // The maximum profit is the same as the maximum profit considering jobs up to index i-1.
        int profit_if_not_taken = dp[i];

        // Option 2: Take the current job (jobs[i])
        // Find the latest non-conflicting job that finishes before or at jobs[i].start.
        // We search in the subarray jobs[0...i-1].
        int prev_job_idx = findLatestNonConflictingJob(jobs, i, jobs[i].start);

        int profit_if_taken = jobs[i].profit;
        if (prev_job_idx != -1) {
            // Add the profit from the non-conflicting previous jobs.
            // dp[prev_job_idx + 1] stores the max profit considering jobs[0...prev_job_idx].
            profit_if_taken += dp[prev_job_idx + 1];
        }

        // dp[i+1] stores the maximum profit considering jobs[0...i].
        dp[i+1] = max(profit_if_not_taken, profit_if_taken);
    }

    int result = dp[n]; // The final answer is the max profit considering all 'n' jobs.
    free(dp);
    return result;
}