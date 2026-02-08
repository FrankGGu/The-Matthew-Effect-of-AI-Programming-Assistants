var maxCompatibilitySum = function(students, mentors) {
    const m = students.length;
    const n = students[0].length;
    let maxScore = 0;

    const calculateScore = (student, mentor) => {
        let score = 0;
        for (let i = 0; i < n; i++) {
            if (student[i] === mentor[i]) {
                score++;
            }
        }
        return score;
    };

    const permute = (arr, start, score) => {
        if (start === arr.length) {
            maxScore = Math.max(maxScore, score);
            return;
        }
        for (let i = start; i < arr.length; i++) {
            [arr[start], arr[i]] = [arr[i], arr[start]];
            const currentScore = calculateScore(students[start], mentors[arr[start]]);
            permute(arr, start + 1, score + currentScore);
            [arr[start], arr[i]] = [arr[i], arr[start]];
        }
    };

    const mentorIndices = Array.from({ length: m }, (_, i) => i);
    permute(mentorIndices, 0, 0);

    return maxScore;
};