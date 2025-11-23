var stoneGameII = function(piles) {
    const n = piles.length;
    const dp = Array.from({ length: n + 1 }, () => Array(n + 1).fill(0));

    for (let i = n - 1; i >= 0; i--) {
        for (let m = 1; m <= n; m++) {
            let maxStones = 0;
            let total = 0;
            for (let x = 1; x <= 2 * m && i + x <= n; x++) {
                total += piles[i + x - 1];
                maxStones = Math.max(maxStones, total - dp[i + x][Math.max(m, x)]);
            }
            dp[i][m] = maxStones;
        }
    }
    return dp[0][1];
};