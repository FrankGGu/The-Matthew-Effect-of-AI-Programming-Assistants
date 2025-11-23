var maxCompatibilitySum = function(students, mentors) {
    const n = students.length;
    const scores = Array.from({ length: n }, () => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            scores[i][j] = calculateScore(students[i], mentors[j]);
        }
    }

    const dp = Array(1 << n).fill(0);

    for (let mask = 0; mask < (1 << n); mask++) {
        let studentIndex = 0;
        for (let j = 0; j < n; j++) {
            if ((mask & (1 << j)) === 0) {
                studentIndex++;
            }
        }

        for (let j = 0; j < n; j++) {
            if ((mask & (1 << j)) === 0) {
                dp[mask | (1 << j)] = Math.max(dp[mask | (1 << j)], dp[mask] + scores[studentIndex][j]);
            }
        }
    }

    return dp[(1 << n) - 1];
};

function calculateScore(student, mentor) {
    let score = 0;
    for (let i = 0; i < student.length; i++) {
        if (student[i] === mentor[i]) {
            score++;
        }
    }
    return score;
}