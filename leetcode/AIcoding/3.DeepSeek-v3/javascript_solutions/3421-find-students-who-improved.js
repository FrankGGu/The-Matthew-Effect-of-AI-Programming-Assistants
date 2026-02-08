var improvedStudents = function(scores) {
    const improved = [];
    const n = scores.length;

    for (let i = 0; i < n; i++) {
        const [id, first, second] = scores[i];
        if (second > first) {
            improved.push(id);
        }
    }

    improved.sort((a, b) => a - b);
    return improved;
};