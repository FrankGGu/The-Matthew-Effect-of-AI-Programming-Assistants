function minGroups(intervals) {
    intervals.sort((a, b) => a[0] - b[0]);
    const endTimes = [];

    for (const [start, end] of intervals) {
        let found = false;
        for (let i = 0; i < endTimes.length; i++) {
            if (endTimes[i] < start) {
                endTimes[i] = end;
                found = true;
                break;
            }
        }
        if (!found) {
            endTimes.push(end);
        }
    }

    return endTimes.length;
}