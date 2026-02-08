var maxFreeTime = function(schedule) {
    schedule.sort((a, b) => a[0] - b[0]);
    let maxGap = 0;
    let prevEnd = schedule[0][1];

    for (let i = 1; i < schedule.length; i++) {
        const [currentStart, currentEnd] = schedule[i];
        if (currentStart > prevEnd) {
            maxGap = Math.max(maxGap, currentStart - prevEnd);
        }
        prevEnd = Math.max(prevEnd, currentEnd);
    }

    return maxGap;
};