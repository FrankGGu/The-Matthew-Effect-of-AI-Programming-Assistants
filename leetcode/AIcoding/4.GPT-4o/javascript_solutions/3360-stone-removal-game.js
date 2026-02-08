var winnerStoneGame = function(piles) {
    let n = piles.length;
    let dp = Array.from({length: n}, () => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        dp[i][i] = piles[i];
    }

    for (let length = 2; length <= n; length++) {
        for (let i = 0; i <= n - length; i++) {
            let j = i + length - 1;
            dp[i][j] = Math.max(piles[i] - dp[i + 1][j], piles[j] - dp[i][j - 1]);
        }
    }

    return dp[0][n - 1] > 0;
};