var maxFreeTime = function(meetings) {
    let events = [];
    for (let meeting of meetings) {
        for (let interval of meeting) {
            events.push([interval[0], 1]);
            events.push([interval[1], -1]);
        }
    }

    events.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        return b[1] - a[1];
    });

    let maxFree = 0;
    let prevEnd = events[0][0];
    let count = 0;

    for (let i = 0; i < events.length; i++) {
        let curr = events[i];
        if (count === 0 && curr[0] > prevEnd) {
            maxFree = Math.max(maxFree, curr[0] - prevEnd);
        }
        count += curr[1];
        prevEnd = curr[0];
    }

    return maxFree;
};