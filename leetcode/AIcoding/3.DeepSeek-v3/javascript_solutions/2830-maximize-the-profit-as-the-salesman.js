var maximizeTheProfit = function(n, offers) {
    offers.sort((a, b) => a[1] - b[1]);
    const dp = new Array(n + 1).fill(0);
    let currentOffer = 0;
    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        while (currentOffer < offers.length && offers[currentOffer][1] < i) {
            currentOffer++;
        }
        while (currentOffer < offers.length && offers[currentOffer][1] === i) {
            const [start, end, gold] = offers[currentOffer];
            dp[i] = Math.max(dp[i], dp[start] + gold);
            currentOffer++;
        }
    }
    return dp[n];
};