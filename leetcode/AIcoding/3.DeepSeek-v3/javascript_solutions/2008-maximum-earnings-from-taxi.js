var maxTaxiEarnings = function(n, rides) {
    rides.sort((a, b) => a[1] - b[1]);
    const dp = new Array(n + 1).fill(0);
    let index = 0;
    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        while (index < rides.length && rides[index][1] === i) {
            const [start, end, tip] = rides[index];
            const profit = end - start + tip;
            dp[i] = Math.max(dp[i], dp[start] + profit);
            index++;
        }
    }
    return dp[n];
};