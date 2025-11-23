var rewardTopKStudents = function(positive_feedback, negative_feedback, report, student_id, k) {
    const positiveSet = new Set(positive_feedback);
    const negativeSet = new Set(negative_feedback);

    const studentScores = [];

    for (let i = 0; i < report.length; i++) {
        let score = 0;
        const words = report[i].split(' ');
        for (const word of words) {
            if (positiveSet.has(word)) {
                score += 3;
            } else if (negativeSet.has(word)) {
                score -= 1;
            }
        }
        studentScores.push({ id: student_id[i], score: score });
    }

    studentScores.sort((a, b) => {
        if (a.score !== b.score) {
            return b.score - a.score; // Sort by score descending
        }
        return a.id - b.id; // Sort by student_id ascending if scores are equal
    });

    const result = [];
    for (let i = 0; i < k; i++) {
        result.push(studentScores[i].id);
    }

    return result;
};