var maximizeTheProfit = function(n, offers) {
    let dp = new Array(n + 1).fill(0);
    offers.sort((a, b) => a[1] - b[1]);
    let j = 0;

    for (let i = 0; i < offers.length; i++) {
        while (j < offers.length && offers[j][1] < offers[i][0]) {
            j++;
        }
        for (let k = n; k >= offers[i][1] - offers[i][0] + 1; k--) {
            dp[k] = Math.max(dp[k], dp[k - (offers[i][1] - offers[i][0] + 1)] + offers[i][2]);
        }
    }

    return Math.max(...dp);
};