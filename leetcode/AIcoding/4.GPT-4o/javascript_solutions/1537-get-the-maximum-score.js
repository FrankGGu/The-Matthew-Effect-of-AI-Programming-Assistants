var maximumScore = function(a, b, c) {
    let scores = [a, b, c].sort((x, y) => y - x);
    let maxScore = 0;
    while (scores[1] > 0) {
        maxScore += 1;
        scores[0] -= 1;
        scores[1] -= 1;
        scores.sort((x, y) => y - x);
    }
    return maxScore;
};