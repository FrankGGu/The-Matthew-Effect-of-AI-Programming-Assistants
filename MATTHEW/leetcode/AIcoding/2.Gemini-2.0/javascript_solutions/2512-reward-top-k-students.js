var rewardTopK = function(positive_feedback, negative_feedback, report, student_id, k) {
    const positive = new Set(positive_feedback);
    const negative = new Set(negative_feedback);

    const scores = [];
    for (let i = 0; i < report.length; i++) {
        const words = report[i].split(" ");
        let score = 0;
        for (const word of words) {
            if (positive.has(word)) {
                score += 3;
            } else if (negative.has(word)) {
                score -= 1;
            }
        }
        scores.push({ id: student_id[i], score: score });
    }

    scores.sort((a, b) => {
        if (b.score !== a.score) {
            return b.score - a.score;
        } else {
            return a.id - b.id;
        }
    });

    const result = [];
    for (let i = 0; i < k && i < scores.length; i++) {
        result.push(scores[i].id);
    }

    return result;
};