function stoneGameIII(stoneGame) {
    const n = stoneGame.length;
    const dp = new Array(n + 1).fill(0);

    for (let i = n - 1; i >= 0; i--) {
        dp[i] = stoneGame[i] - dp[i + 1];
        if (i + 1 < n) {
            dp[i] = Math.max(dp[i], stoneGame[i] + stoneGame[i + 1] - dp[i + 2]);
        }
    }

    if (dp[0] > 0) {
        return "Alice";
    } else if (dp[0] < 0) {
        return "Bob";
    } else {
        return "Tie";
    }
}