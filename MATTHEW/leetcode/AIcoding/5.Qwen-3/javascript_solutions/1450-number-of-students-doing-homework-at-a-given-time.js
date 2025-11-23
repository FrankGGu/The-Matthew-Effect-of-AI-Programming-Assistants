function busyStudent(startTime, endTime) {
    let count = 0;
    for (let i = 0; i < startTime.length; i++) {
        if (startTime[i] <= endTime[i]) {
            count++;
        }
    }
    return count;
}