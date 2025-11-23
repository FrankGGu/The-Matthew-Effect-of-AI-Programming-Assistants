var minimumTimeRequired = function(jobs, k) {
    jobs.sort((a, b) => b - a);

    let low = Math.max(...jobs);
    let high = jobs.reduce((sum, job) => sum + job, 0);
    let result = high;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        let workerLoads = new Array(k).fill(0);

        if (canAssign(jobs, k, mid, 0, workerLoads)) {
            result = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return result;
};

function canAssign(jobs, k, maxTime, jobIndex, workerLoads) {
    if (jobIndex === jobs.length) {
        return true;
    }

    let job = jobs[jobIndex];

    for (let i = 0; i < k; i++) {
        if (workerLoads[i] + job <= maxTime) {
            workerLoads[i] += job;
            if (canAssign(jobs, k, maxTime, jobIndex + 1, workerLoads)) {
                return true;
            }
            workerLoads[i] -= job;

            if (workerLoads[i] === 0) {
                break;
            }
        }
    }
    return false;
}