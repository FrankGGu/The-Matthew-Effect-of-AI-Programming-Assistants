var maximizeTheProfit = function(n, offers) {
    offers.sort((a, b) => a[1] - b[1]);
    const dp = new Array(offers.length + 1).fill(0);

    for (let i = 1; i <= offers.length; i++) {
        const [start, end, gold] = offers[i - 1];
        let prevIndex = -1;
        let low = 0;
        let high = i - 2;

        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (offers[mid][1] < start) {
                prevIndex = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        dp[i] = Math.max(dp[i - 1], gold + (prevIndex === -1 ? 0 : dp[prevIndex + 1]));
    }

    return dp[offers.length];
};