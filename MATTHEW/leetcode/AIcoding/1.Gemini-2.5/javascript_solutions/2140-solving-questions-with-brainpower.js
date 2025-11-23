var mostPoints = function(questions) {
    const n = questions.length;
    const dp = new Array(n + 1).fill(0);

    for (let i = n - 1; i >= 0; i--) {
        const points = questions[i][0];
        const brainpower = questions[i][1];

        const skipPoints = dp[i + 1];

        let solvePoints = points;
        const nextQuestionIndex = i + 1 + brainpower;

        if (nextQuestionIndex < n) {
            solvePoints += dp[nextQuestionIndex];
        }

        dp[i] = Math.max(skipPoints, solvePoints);
    }

    return dp[0];
};