var maxTaskAssign = function(tasks, workers, pills, strength) {
    tasks.sort((a, b) => a - b);
    workers.sort((a, b) => a - b);

    let low = 0;
    let high = Math.min(tasks.length, workers.length);
    let ans = 0;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        if (canAssign(tasks, workers, pills, strength, mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;

    function canAssign(tasks, workers, pills, strength, numTasks) {
        let taskSubset = tasks.slice(tasks.length - numTasks);
        let workerSubset = workers.slice(workers.length - numTasks).sort((a, b) => a - b);
        let j = numTasks - 1;
        let pillCount = pills;

        for (let i = numTasks - 1; i >= 0; i--) {
            if (workerSubset[i] >= taskSubset[j]) {
                j--;
            } else if (pillCount > 0 && workerSubset[i] + strength >= taskSubset[j]) {
                pillCount--;
                j--;
            } else {
                return false;
            }
        }
        return true;
    }
};