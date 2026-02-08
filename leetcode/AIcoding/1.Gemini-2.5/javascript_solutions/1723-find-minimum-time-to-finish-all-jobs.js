var minimumTimeRequired = function(jobs, k) {
    jobs.sort((a, b) => b - a); // Sort jobs in descending order for better pruning

    let minTime = Infinity;
    let workerLoads = new Array(k).fill(0);

    function backtrack(jobIndex, currentMaxTime) {
        // Pruning 1: If the current maximum time among workers is already
        // greater than or equal to the best minimum time found so far,
        // then this path cannot lead to a better solution.
        if (currentMaxTime >= minTime) {
            return;
        }

        // Base case: All jobs have been assigned.
        // Update the global minimum time.
        if (jobIndex === jobs.length) {
            minTime = currentMaxTime;
            return;
        }

        // Try assigning the current job to each worker
        for (let i = 0; i < k; i++) {
            const originalLoad = workerLoads[i]; // Store original load to check if worker was empty

            // Pruning 2: If assigning the current job to this worker would
            // immediately exceed or equal the best minimum time found so far,
            // then skip this worker.
            if (originalLoad + jobs[jobIndex] >= minTime) {
                continue;
            }

            // Assign the current job to worker 'i'
            workerLoads[i] += jobs[jobIndex];

            // Recursively call for the next job, updating the current maximum time
            backtrack(jobIndex + 1, Math.max(currentMaxTime, workerLoads[i]));

            // Backtrack: Remove the current job from worker 'i'
            workerLoads[i] -= jobs[jobIndex];

            // Pruning 3 (Symmetry Breaking): If this worker was empty (load was 0)
            // before assigning the current job, and we just assigned the job to it,
            // we don't need to try assigning this job to any subsequent empty workers.
            // Assigning to another empty worker would lead to an identical state
            // (just a permutation of which empty worker got the job).
            if (originalLoad === 0) {
                break; // All subsequent empty workers would be symmetrical
            }
        }
    }

    backtrack(0, 0); // Start with the first job and initial max time of 0
    return minTime;
};