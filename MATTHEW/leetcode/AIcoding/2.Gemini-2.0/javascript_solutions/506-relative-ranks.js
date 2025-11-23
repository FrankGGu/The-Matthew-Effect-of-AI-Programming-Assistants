var relativeRanks = function(score) {
    const n = score.length;
    const sortedScore = [...score].sort((a, b) => b - a);
    const rankMap = new Map();
    for (let i = 0; i < n; i++) {
        rankMap.set(sortedScore[i], i + 1);
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        const rank = rankMap.get(score[i]);
        if (rank === 1) {
            result.push("Gold Medal");
        } else if (rank === 2) {
            result.push("Silver Medal");
        } else if (rank === 3) {
            result.push("Bronze Medal");
        } else {
            result.push(rank.toString());
        }
    }

    return result;
};