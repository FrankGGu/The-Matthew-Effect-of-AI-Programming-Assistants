var hardestWorker = function(n, logs) {
    let maxTime = logs[0][1];
    let employee = logs[0][0];
    let prevTime = logs[0][1];

    for (let i = 1; i < logs.length; i++) {
        let currentTime = logs[i][1] - logs[i-1][1];
        if (currentTime > maxTime) {
            maxTime = currentTime;
            employee = logs[i][0];
        } else if (currentTime === maxTime) {
            employee = Math.min(employee, logs[i][0]);
        }
    }

    let firstTime = logs[0][1];
    if (firstTime > maxTime) {
        maxTime = firstTime;
        employee = logs[0][0];
    } else if (firstTime === maxTime && logs[0][0] < employee) {
        employee = logs[0][0];
    }

    return employee;
};