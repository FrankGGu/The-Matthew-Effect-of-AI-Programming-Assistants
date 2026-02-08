function minimumTimeToFinishAllJobs(jobs, workers) {
    const n = jobs.length;
    const m = workers.length;

    function canAssign(time) {
        const workerTimes = new Array(m).fill(0);
        const jobIndices = [...Array(n).keys()].sort((a, b) => jobs[b] - jobs[a]);

        for (const job of jobIndices) {
            let assigned = false;
            for (let i = 0; i < m; i++) {
                if (workerTimes[i] + jobs[job] <= time) {
                    workerTimes[i] += jobs[job];
                    assigned = true;
                    break;
                }
            }
            if (!assigned) return false;
        }
        return true;
    }

    jobs.sort((a, b) => b - a);
    workers.sort((a, b) => b - a);

    let left = 0;
    let right = jobs.reduce((a, b) => a + b, 0);

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (canAssign(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}