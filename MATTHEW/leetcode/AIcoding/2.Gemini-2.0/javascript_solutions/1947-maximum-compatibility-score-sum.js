var maxCompatibilitySum = function(students, mentors) {
    const n = students.length;
    let maxScore = 0;

    function calculateScore(student, mentor) {
        let score = 0;
        for (let i = 0; i < student.length; i++) {
            if (student[i] === mentor[i]) {
                score++;
            }
        }
        return score;
    }

    function permute(arr, l, r) {
        if (l === r) {
            let currentScore = 0;
            for (let i = 0; i < n; i++) {
                currentScore += calculateScore(students[i], mentors[arr[i]]);
            }
            maxScore = Math.max(maxScore, currentScore);
        } else {
            for (let i = l; i <= r; i++) {
                [arr[l], arr[i]] = [arr[i], arr[l]];
                permute(arr, l + 1, r);
                [arr[l], arr[i]] = [arr[i], arr[l]]; // backtrack
            }
        }
    }

    const mentorIndices = Array.from({ length: n }, (_, i) => i);
    permute(mentorIndices, 0, n - 1);

    return maxScore;
};