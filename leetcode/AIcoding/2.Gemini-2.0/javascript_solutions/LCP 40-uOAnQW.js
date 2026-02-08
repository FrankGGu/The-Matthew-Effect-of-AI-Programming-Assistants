var maxScoreSightseeingPair = function(cards) {
    let maxScore = 0;
    let maxVal = cards[0] + 0;

    for (let j = 1; j < cards.length; j++) {
        maxScore = Math.max(maxScore, maxVal + cards[j] - j);
        maxVal = Math.max(maxVal, cards[j] + j);
    }

    return maxScore;
};