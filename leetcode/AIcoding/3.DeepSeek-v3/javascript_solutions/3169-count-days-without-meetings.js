var countDays = function(days, meetings) {
    meetings.sort((a, b) => a[0] - b[0]);
    let merged = [];
    for (let meeting of meetings) {
        if (merged.length === 0 || merged[merged.length - 1][1] < meeting[0]) {
            merged.push([...meeting]);
        } else {
            merged[merged.length - 1][1] = Math.max(merged[merged.length - 1][1], meeting[1]);
        }
    }
    let busyDays = 0;
    for (let interval of merged) {
        busyDays += interval[1] - interval[0] + 1;
    }
    return days - busyDays;
};