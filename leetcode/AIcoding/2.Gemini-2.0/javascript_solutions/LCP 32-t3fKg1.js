var canFinish = function(tasks, workers, pills, strength) {
    tasks.sort((a, b) => a - b);
    workers.sort((a, b) => a - b);

    let l = 0;
    let r = tasks.length - 1;

    while (l <= r) {
        let mid = Math.floor((l + r) / 2);
        if (check(tasks.slice(tasks.length - mid - 1), workers.slice(), pills, strength)) {
            l = mid + 1;
        } else {
            r = mid - 1;
        }
    }

    return l > 0;

    function check(taskSubset, workerSubset, pills, strength) {
        let workerIndex = workerSubset.length - 1;
        for (let i = taskSubset.length - 1; i >= 0; i--) {
            if (workerSubset[workerIndex] >= taskSubset[i]) {
                workerIndex--;
            } else {
                if (pills > 0) {
                    pills--;
                    if (workerSubset[workerIndex] + strength >= taskSubset[i]) {
                        workerIndex--;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            }
            if (workerIndex < 0) return false;
        }
        return true;
    }
};

var maxTaskAssign = function(tasks, workers, pills, strength) {
    tasks.sort((a, b) => a - b);
    workers.sort((a, b) => a - b);

    let l = 0;
    let r = Math.min(tasks.length, workers.length);

    while (l <= r) {
        let mid = Math.floor((l + r) / 2);
        if (check(tasks.slice(0, mid), workers.slice(), pills, strength)) {
            l = mid + 1;
        } else {
            r = mid - 1;
        }
    }

    return r;

    function check(taskSubset, workerSubset, pills, strength) {
        taskSubset = taskSubset.slice().sort((a, b) => a - b);
        workerSubset = workerSubset.slice().sort((a, b) => a - b);
        let workerIndex = workerSubset.length - 1;
        for (let i = taskSubset.length - 1; i >= 0; i--) {
            if (workerSubset[workerIndex] >= taskSubset[i]) {
                workerIndex--;
            } else {
                if (pills > 0) {
                    pills--;
                    if (workerSubset[workerIndex] + strength >= taskSubset[i]) {
                        workerIndex--;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            }
            if (workerIndex < 0) return false;
        }
        return true;
    }
};