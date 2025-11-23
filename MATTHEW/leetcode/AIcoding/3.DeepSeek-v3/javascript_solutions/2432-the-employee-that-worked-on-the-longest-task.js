var hardestWorker = function(n, logs) {
    let maxDuration = logs[0][1];
    let result = logs[0][0];

    for (let i = 1; i < logs.length; i++) {
        const duration = logs[i][1] - logs[i - 1][1];
        if (duration > maxDuration) {
            maxDuration = duration;
            result = logs[i][0];
        } else if (duration === maxDuration) {
            if (logs[i][0] < result) {
                result = logs[i][0];
            }
        }
    }

    return result;
};