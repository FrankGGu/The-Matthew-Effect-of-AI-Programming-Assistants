function hardestWorker(n, logs) {
    let maxTime = 0;
    let employeeId = 0;

    for (let i = 0; i < logs.length; i++) {
        let [id, time] = logs[i];
        let duration = i === 0 ? time : time - logs[i - 1][1];

        if (duration > maxTime || (duration === maxTime && id < employeeId)) {
            maxTime = duration;
            employeeId = id;
        }
    }

    return employeeId;
}