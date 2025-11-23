var findRelativeRanks = function(score) {
    const n = score.length;
    const scoreToRankMap = new Map();
    const sortedScores = [...score].sort((a, b) => b - a);

    for (let i = 0; i < n; i++) {
        const currentScore = sortedScores[i];
        let rankString;
        if (i === 0) {
            rankString = "Gold Medal";
        } else if (i === 1) {
            rankString = "Silver Medal";
        } else if (i === 2) {
            rankString = "Bronze Medal";
        } else {
            rankString = (i + 1).toString();
        }
        scoreToRankMap.set(currentScore, rankString);
    }

    const result = new Array(n);
    for (let i = 0; i < n; i++) {
        result[i] = scoreToRankMap.get(score[i]);
    }

    return result;
};