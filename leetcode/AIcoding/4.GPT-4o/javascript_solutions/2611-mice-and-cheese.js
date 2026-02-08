var miceAndCheese = function(mouse, cheese) {
    const n = mouse.length;
    let dp = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        dp[i + 1] = dp[i] + cheese[i];
    }

    let maxScore = 0;
    for (let i = 0; i < n; i++) {
        maxScore = Math.max(maxScore, dp[i] + cheese[i + 1] - (mouse[i] || 0));
    }

    return maxScore;
};