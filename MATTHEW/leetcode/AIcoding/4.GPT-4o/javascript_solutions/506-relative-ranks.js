var findRelativeRanks = function(score) {
    const sortedScores = [...score].sort((a, b) => b - a);
    const rankMap = {};

    for (let i = 0; i < sortedScores.length; i++) {
        if (i === 0) rankMap[sortedScores[i]] = 'Gold Medal';
        else if (i === 1) rankMap[sortedScores[i]] = 'Silver Medal';
        else if (i === 2) rankMap[sortedScores[i]] = 'Bronze Medal';
        else rankMap[sortedScores[i]] = (i + 1).toString();
    }

    return score.map(s => rankMap[s]);
};