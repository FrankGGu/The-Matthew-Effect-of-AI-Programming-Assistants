var maxFreeTime = function(schedule) {
    schedule.sort((a, b) => a[0] - b[0]);
    let merged = [];
    for (let interval of schedule) {
        if (merged.length === 0 || merged[merged.length - 1][1] < interval[0]) {
            merged.push(interval);
        } else {
            merged[merged.length - 1][1] = Math.max(merged[merged.length - 1][1], interval[1]);
        }
    }
    let maxGap = 0;
    for (let i = 1; i < merged.length; i++) {
        maxGap = Math.max(maxGap, merged[i][0] - merged[i - 1][1]);
    }
    return maxGap;
};