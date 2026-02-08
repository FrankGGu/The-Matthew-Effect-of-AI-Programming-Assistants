var findChampion = function(competitions) {
    const scoreMap = new Map();

    for (const [winner, loser] of competitions) {
        scoreMap.set(winner, (scoreMap.get(winner) || 0) + 3);
        scoreMap.set(loser, (scoreMap.get(loser) || 0));
    }

    let champion = null;
    let maxScore = -1;

    for (const [team, score] of scoreMap) {
        if (score > maxScore) {
            maxScore = score;
            champion = team;
        }
    }

    return champion;
};