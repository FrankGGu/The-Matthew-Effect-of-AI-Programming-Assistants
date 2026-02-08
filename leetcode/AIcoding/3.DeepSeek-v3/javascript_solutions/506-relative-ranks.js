var findRelativeRanks = function(score) {
    const sorted = [...score].sort((a, b) => b - a);
    const rankMap = {};
    for (let i = 0; i < sorted.length; i++) {
        if (i === 0) {
            rankMap[sorted[i]] = "Gold Medal";
        } else if (i === 1) {
            rankMap[sorted[i]] = "Silver Medal";
        } else if (i === 2) {
            rankMap[sorted[i]] = "Bronze Medal";
        } else {
            rankMap[sorted[i]] = (i + 1).toString();
        }
    }
    return score.map(s => rankMap[s]);
};