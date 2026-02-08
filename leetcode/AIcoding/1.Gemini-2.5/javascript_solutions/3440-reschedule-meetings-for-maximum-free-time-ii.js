var maxFreeTime = function(meetings) {
    if (meetings.length <= 1) {
        return 0;
    }

    meetings.sort((a, b) => a[0] - b[0]);

    const merged = [];
    for (const meeting of meetings) {
        if (merged.length === 0 || meeting[0] > merged[merged.length - 1][1]) {
            merged.push(meeting);
        } else {
            merged[merged.length - 1][1] = Math.max(merged[merged.length - 1][1], meeting[1]);
        }
    }

    let maxGap = 0;
    for (let i = 0; i < merged.length - 1; i++) {
        const gap = merged[i+1][0] - merged[i][1];
        maxGap = Math.max(maxGap, gap);
    }

    return maxGap;
};