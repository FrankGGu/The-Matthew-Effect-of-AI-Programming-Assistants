var maxCompatibilitySum = function(mentors, students) {
    const m = mentors.length;
    const n = students.length;

    const compat_scores = Array(m).fill(0).map(() => Array(n).fill(0));
    const num_questions = mentors[0].length;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let current_score = 0;
            for (let k = 0; k < num_questions; k++) {
                if (mentors[i][k] === students[j][k]) {
                    current_score++;
                }
            }
            compat_scores[i][j] = current_score;
        }
    }

    const memo = Array(m).fill(0).map(() => Array(1 << n).fill(-1));

    function dp(mentor_idx, student_mask) {
        if (mentor_idx === m) {
            return 0;
        }

        if (memo[mentor_idx][student_mask] !== -1) {
            return memo[mentor_idx][student_mask];
        }

        let max_current_score = 0;

        for (let j = 0; j < n; j++) {
            if (!((student_mask >> j) & 1)) {
                max_current_score = Math.max(
                    max_current_score,
                    compat_scores[mentor_idx][j] + dp(mentor_idx + 1, student_mask | (1 << j))
                );
            }
        }

        memo[mentor_idx][student_mask] = max_current_score;
        return max_current_score;
    }

    return dp(0, 0);
};