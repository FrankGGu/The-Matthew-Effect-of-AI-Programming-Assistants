var maxScoreSightseeingPair = function(values) {
    let maxScore = 0;
    let max_i_plus_val_i = values[0] + 0;

    for (let j = 1; j < values.length; j++) {
        maxScore = Math.max(maxScore, max_i_plus_val_i + values[j] - j);
        max_i_plus_val_i = Math.max(max_i_plus_val_i, values[j] + j);
    }

    return maxScore;
};