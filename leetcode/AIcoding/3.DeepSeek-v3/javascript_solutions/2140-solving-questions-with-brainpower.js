var mostPoints = function(questions) {
    const n = questions.length;
    const dp = new Array(n).fill(0);
    dp[n - 1] = questions[n - 1][0];

    for (let i = n - 2; i >= 0; i--) {
        const [points, brainpower] = questions[i];
        const next = i + brainpower + 1;
        if (next < n) {
            dp[i] = Math.max(points + dp[next], dp[i + 1]);
        } else {
            dp[i] = Math.max(points, dp[i + 1]);
        }
    }

    return dp[0];
};