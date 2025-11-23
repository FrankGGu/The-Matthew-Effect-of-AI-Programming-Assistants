var maxFreeTime = function(intervals) {
    if (intervals.length <= 1) {
        return 0;
    }

    intervals.sort((a, b) => a[0] - b[0]);

    const merged = [];
    let currentMerged = intervals[0];

    for (let i = 1; i < intervals.length; i++) {
        const [currentStart, currentEnd] = currentMerged;
        const [nextStart, nextEnd] = intervals[i];

        if (nextStart <= currentEnd) {
            currentMerged[1] = Math.max(currentEnd, nextEnd);
        } else {
            merged.push(currentMerged);
            currentMerged = intervals[i];
        }
    }
    merged.push(currentMerged);

    let maxGap = 0;
    for (let i = 0; i < merged.length - 1; i++) {
        const endOfCurrent = merged[i][1];
        const startOfNext = merged[i+1][0];
        maxGap = Math.max(maxGap, startOfNext - endOfCurrent);
    }

    return maxGap;
};