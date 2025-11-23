function longestTask(logs) {
    let maxTime = 0;
    let employeeId = 0;

    for (const [id, start, end] of logs) {
        const duration = end - start;
        if (duration > maxTime) {
            maxTime = duration;
            employeeId = id;
        } else if (duration === maxTime && id < employeeId) {
            employeeId = id;
        }
    }

    return employeeId;
}