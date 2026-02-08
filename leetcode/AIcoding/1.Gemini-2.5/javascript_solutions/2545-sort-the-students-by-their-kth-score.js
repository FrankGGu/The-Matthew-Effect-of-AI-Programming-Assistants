var sortTheStudents = function(score, k) {
    score.sort((a, b) => a[k] - b[k]);
    return score;
};