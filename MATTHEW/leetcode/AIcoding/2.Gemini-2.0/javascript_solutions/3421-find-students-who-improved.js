var findStudents = function(score) {
    const n = score.length;
    const result = [];

    for (let i = 0; i < n; i++) {
        if (score[i][1] > score[i][0]) {
            result.push(score[i][2]);
        }
    }

    return result;
};