var scoreOfStudents = function(s, answers) {
    const mod = 1e9 + 7;
    const n = s.length;
    const dp = new Array(n + 1).fill(0).map(() => new Array(n + 1).fill(0));
    const correctAnswer = eval(s) % mod;

    function calculateScore(l, r) {
        if (dp[l][r] !== 0) return dp[l][r];
        if (l === r) {
            const num = Number(s.substring(l, r + 1));
            dp[l][r] = new Set([num]);
            return dp[l][r];
        }
        const res = new Set();
        for (let i = l; i < r; i++) {
            if (s[i] === '+' || s[i] === '-') {
                const leftScores = calculateScore(l, i - 1);
                const rightScores = calculateScore(i + 1, r);
                for (const left of leftScores) {
                    for (const right of rightScores) {
                        if (s[i] === '+') {
                            res.add((left + right) % mod);
                        } else {
                            res.add((left - right + mod) % mod);
                        }
                    }
                }
            }
        }
        dp[l][r] = res;
        return res;
    }

    calculateScore(0, n - 1);
    let score = 0;
    const validScores = dp[0][n - 1];

    for (const answer of answers) {
        if (validScores.has(answer)) {
            score += 5;
        } else if (answer === correctAnswer) {
            score += 2;
        }
    }

    return score;
};