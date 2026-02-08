var topStudents = function(positive_feedback, negative_feedback, report, student_id, k) {
    const positiveSet = new Set(positive_feedback);
    const negativeSet = new Set(negative_feedback);

    const students = [];

    for (let i = 0; i < report.length; i++) {
        const words = report[i].split(' ');
        let score = 0;
        for (const word of words) {
            if (positiveSet.has(word)) {
                score += 3;
            } else if (negativeSet.has(word)) {
                score -= 1;
            }
        }
        students.push({ id: student_id[i], score });
    }

    students.sort((a, b) => {
        if (a.score !== b.score) {
            return b.score - a.score;
        } else {
            return a.id - b.id;
        }
    });

    const result = [];
    for (let i = 0; i < k; i++) {
        result.push(students[i].id);
    }

    return result;
};