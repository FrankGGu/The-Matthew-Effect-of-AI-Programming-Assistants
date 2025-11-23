#include <stdbool.h>
#include <stdlib.h>
#include <string.h> // For memset

static int* g_jobs;
static int g_n;
static int g_k;
static int g_max_time;

int compare(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

bool can_distribute(int job_idx, int* worker_loads) {
    // Base case: All jobs have been assigned
    if (job_idx == g_n) {
        return true;
    }

    int current_job = g_jobs[job_idx];

    // Optimization: If multiple workers are currently empty,
    // assigning the current job to any of them leads to a symmetric state.
    // We only need to try assigning to the first empty worker encountered.
    // This flag ensures we only use one empty worker for the current job.
    bool tried_empty_worker = false;

    for (int w = 0; w < g_k; ++w) {
        if (worker_loads[w] == 0) {
            if (tried_empty_worker) {
                continue; // Skip if we already tried an empty worker for this job
            }
            tried_empty_worker = true;
        }

        // If assigning the current job to worker 'w' does not exceed the maximum allowed time
        if (worker_loads[w] + current_job <= g_max_time) {
            worker_loads[w] += current_job; // Assign the job
            if (can_distribute(job_idx + 1, worker_loads)) {
                return true; // If successful, propagate true
            }
            worker_loads[w] -= current_job; // Backtrack: unassign the job
        }
    }
    return false; // No way to assign the current job
}

int minimumTimeRequired(int* jobs, int jobsSize, int k) {
    g_jobs = jobs;
    g_n = jobsSize;
    g_k = k;

    // Sort jobs in descending order. This helps prune the search space faster
    // in the backtracking function by failing early with larger jobs.
    qsort(g_jobs, g_n, sizeof(int), compare);

    long long sum_jobs = 0;
    int max_job = 0;
    for (int i = 0; i < g_n; ++i) {
        sum_jobs += g_jobs[i];
        if (g_jobs[i] > max_job) {
            max_job = g_jobs[i];
        }
    }

    // Binary search for the minimum possible maximum working time
    int low = max_job;         // Minimum possible maximum time is the largest single job
    int high = (int)sum_jobs;  // Maximum possible maximum time is if one worker does all jobs
    int result = high;         // Initialize result with a valid upper bound

    // Allocate memory for worker loads. This array will be reused for each check.
    int* worker_loads = (int*)malloc(sizeof(int) * g_k);
    if (!worker_loads) {
        // Handle allocation error, though LeetCode typically guarantees success for small N.
        return -1; 
    }

    while (low <= high) {
        int mid = low + (high - low) / 2; // Calculate midpoint
        g_max_time = mid;                 // Set the global max_time for the check function

        // Reset worker loads for the current check
        memset(worker_loads, 0, sizeof(int) * g_k);

        // Check if it's possible to distribute all jobs such that no worker exceeds 'mid' time
        if (can_distribute(0, worker_loads)) {
            result = mid;      // It's possible, try for a smaller maximum time
            high = mid - 1;
        } else {
            low = mid + 1;     // Not possible, need more time
        }
    }

    free(worker_loads); // Free allocated memory
    return result;
}