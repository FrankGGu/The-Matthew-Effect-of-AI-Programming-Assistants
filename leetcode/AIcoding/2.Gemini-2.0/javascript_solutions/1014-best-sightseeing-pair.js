var maxScoreSightseeingPair = function(values) {
    let maxScore = 0;
    let maxVal = values[0] + 0;

    for (let j = 1; j < values.length; j++) {
        maxScore = Math.max(maxScore, maxVal + values[j] - j);
        maxVal = Math.max(maxVal, values[j] + j);
    }

    return maxScore;
};