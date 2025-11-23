#include <limits.h>
#include <stdlib.h> // For qsort and calloc

static int* g_jobTimes;
static int g_numJobs;
static int g_numWorkers;
static int g_minMaxTime;

static int compareIntDesc(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

static void backtrack(int jobIndex, int* workerLoads) {
    if (jobIndex == g_numJobs) {
        int currentMax = 0;
        for (int i = 0; i < g_numWorkers; i++) {
            if (workerLoads[i] > currentMax) {
                currentMax = workerLoads[i];
            }
        }
        if (currentMax < g_minMaxTime) {
            g_minMaxTime = currentMax;
        }
        return;
    }

    // Pruning 1: If the current maximum load among workers is already
    // greater than or equal to the best found so far, no need to continue this path.
    int currentMaxLoad = 0;
    for (int i = 0; i < g_numWorkers; i++) {
        if (workerLoads[i] > currentMaxLoad) {
            currentMaxLoad = workerLoads[i];
        }
    }
    if (currentMaxLoad >= g_minMaxTime) {
        return;
    }

    // Try assigning the current job to each worker
    for (int i = 0; i < g_numWorkers; i++) {
        // Pruning 2: If this worker is idle and a previous worker is also idle,
        // assigning the job to this worker is equivalent to assigning it to the previous idle worker.
        // This avoids redundant permutations when workers are indistinguishable.
        // This optimization is only valid if workers are indistinguishable and job order is fixed.
        if (i > 0 && workerLoads[i - 1] == 0 && workerLoads[i] == 0) {
            continue;
        }

        workerLoads[i] += g_jobTimes[jobIndex];
        backtrack(jobIndex + 1, workerLoads);
        workerLoads[i] -= g_jobTimes[jobIndex]; // Backtrack: remove job from worker
    }
}

int minimumTimeRequired(int* jobs, int jobsSize, int k) {
    g_jobTimes = jobs;
    g_numJobs = jobsSize;
    g_numWorkers = k;
    g_minMaxTime = INT_MAX;

    // Sort jobs in descending order. This helps pruning branches earlier in backtracking.
    qsort(g_jobTimes, g_numJobs, sizeof(int), compareIntDesc);

    // Allocate memory for worker loads and initialize to 0
    int* workerLoads = (int*)calloc(g_numWorkers, sizeof(int));

    backtrack(0, workerLoads);

    free(workerLoads); // Free allocated memory

    return g_minMaxTime;
}