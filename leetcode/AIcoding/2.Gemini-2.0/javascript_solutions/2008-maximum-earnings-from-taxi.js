var maxTaxiEarnings = function(n, rides) {
    rides.sort((a, b) => a[1] - b[1]);
    const dp = new Array(rides.length + 1).fill(0);
    for (let i = 1; i <= rides.length; i++) {
        const [start, end, tip] = rides[i - 1];
        let prevIndex = 0;
        let left = 0;
        let right = i - 1;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (rides[mid][1] <= start) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        if (rides[left - 1] && rides[left - 1][1] <= start) {
            prevIndex = left;
        }

        dp[i] = Math.max(dp[i - 1], dp[prevIndex] + end - start + tip);
    }
    return dp[rides.length];
};