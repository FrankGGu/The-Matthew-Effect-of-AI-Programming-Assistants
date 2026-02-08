var bestClosingTime = function(customers) {
    let maxScore = 0, score = 0, bestHour = -1;
    for (let i = 0; i < customers.length; i++) {
        score += customers[i] === 'Y' ? 1 : -1;
        if (score > maxScore) {
            maxScore = score;
            bestHour = i;
        }
    }
    return bestHour + 1;
};