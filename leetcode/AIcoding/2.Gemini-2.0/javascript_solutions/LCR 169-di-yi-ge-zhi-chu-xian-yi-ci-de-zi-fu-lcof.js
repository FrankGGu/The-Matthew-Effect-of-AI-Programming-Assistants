var dismantlingAction = function(moves) {
    let n = moves.length;
    if (n <= 2) return n;
    let dp = new Array(n).fill(1);
    for (let i = 1; i < n; i++) {
        if (moves[i] != moves[i - 1]) {
            dp[i] = dp[i - 1] + 1;
        } else {
            if (i >= 2 && moves[i] != moves[i - 2]) {
                dp[i] = dp[i - 2] + 1;
            } else {
                dp[i] = 1;
            }
        }
    }
    return dp[n - 1];
};