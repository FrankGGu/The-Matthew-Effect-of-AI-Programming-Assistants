var hardestWorker = function(n, logs) {
    let maxDuration = 0;
    let hardestWorkerId = logs[0][0];
    let previousFinishTime = 0;

    for (let i = 0; i < logs.length; i++) {
        const employeeId = logs[i][0];
        const finishTime = logs[i][1];
        const currentDuration = finishTime - previousFinishTime;

        if (currentDuration > maxDuration) {
            maxDuration = currentDuration;
            hardestWorkerId = employeeId;
        } else if (currentDuration === maxDuration) {
            hardestWorkerId = Math.min(hardestWorkerId, employeeId);
        }

        previousFinishTime = finishTime;
    }

    return hardestWorkerId;
};