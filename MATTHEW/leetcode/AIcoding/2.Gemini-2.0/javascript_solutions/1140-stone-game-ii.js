var stoneGameII = function(piles) {
    const n = piles.length;
    const sum = new Array(n + 1).fill(0);
    for (let i = n - 1; i >= 0; i--) {
        sum[i] = sum[i + 1] + piles[i];
    }
    const dp = new Array(n).fill(null).map(() => new Array(n + 1).fill(0));

    function solve(i, m) {
        if (i >= n) {
            return 0;
        }
        if (dp[i][m] !== 0) {
            return dp[i][m];
        }

        let maxStones = 0;
        for (let x = 1; x <= 2 * m; x++) {
            if (i + x > n) {
                break;
            }
            maxStones = Math.max(maxStones, sum[i] - solve(i + x, Math.max(m, x)));
        }

        dp[i][m] = maxStones;
        return maxStones;
    }

    return solve(0, 1);
};