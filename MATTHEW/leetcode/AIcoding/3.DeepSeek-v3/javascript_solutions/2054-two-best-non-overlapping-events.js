var maxTwoEvents = function(events) {
    events.sort((a, b) => a[0] - b[0]);
    const n = events.length;
    const dp = new Array(n + 1).fill(0);
    let maxVal = 0;
    let res = 0;
    let j = 0;
    const sortedEvents = [...events].sort((a, b) => a[1] - b[1]);
    const maxSoFar = [];
    let currentMax = 0;
    for (const event of sortedEvents) {
        currentMax = Math.max(currentMax, event[2]);
        maxSoFar.push(currentMax);
    }

    for (let i = 0; i < n; i++) {
        const [start, end, val] = events[i];
        while (j < n && sortedEvents[j][1] < start) {
            j++;
        }
        const prevMax = j > 0 ? maxSoFar[j - 1] : 0;
        dp[i + 1] = Math.max(dp[i], prevMax + val);
        res = Math.max(res, dp[i + 1]);
    }
    return res;
};