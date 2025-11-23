var minDistance = function(houses, k) {
    houses.sort((a, b) => a - b);
    const n = houses.length;
    const cost = Array.from({ length: n }, () => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            const median = houses[Math.floor((i + j) / 2)];
            let total = 0;
            for (let m = i; m <= j; m++) {
                total += Math.abs(houses[m] - median);
            }
            cost[i][j] = total;
        }
    }

    const dp = Array.from({ length: n }, () => Array(k + 1).fill(Infinity));

    for (let i = 0; i < n; i++) {
        dp[i][1] = cost[0][i];
    }

    for (let l = 2; l <= k; l++) {
        for (let j = 0; j < n; j++) {
            for (let i = 0; i < j; i++) {
                dp[j][l] = Math.min(dp[j][l], dp[i][l - 1] + cost[i + 1][j]);
            }
        }
    }

    return dp[n - 1][k];
};