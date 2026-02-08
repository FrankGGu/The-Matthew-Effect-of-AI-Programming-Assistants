var mostPoints = function(questions) {
    const n = questions.length;
    const dp = new Array(n + 1).fill(0);

    for (let i = n - 1; i >= 0; i--) {
        const [points, brainpower] = questions[i];
        const nextQuestion = i + brainpower + 1;

        dp[i] = Math.max(points + (nextQuestion < n ? dp[nextQuestion] : 0), dp[i + 1]);
    }

    return dp[0];
};