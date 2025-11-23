var maxScore = function(intervals, scores) {
    const n = intervals.length;
    const events = [];
    for (let i = 0; i < n; i++) {
        events.push([intervals[i][0], 0, i]);
        events.push([intervals[i][1] + 1, 1, i]);
    }
    events.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        return a[1] - b[1];
    });

    const dp = new Array(events.length + 1).fill(0);
    const intervalIndex = new Array(n).fill(-1);

    for (let i = 1; i <= events.length; i++) {
        const [time, type, index] = events[i - 1];
        dp[i] = dp[i - 1];

        if (type === 1) {
            const startEventIndex = intervalIndex[index];
            if (startEventIndex !== -1) {
                dp[i] = Math.max(dp[i], dp[startEventIndex] + scores[index]);
            }
        } else {
            intervalIndex[index] = i - 1;
        }
    }

    return dp[events.length];
};